//
//  ShowsCollectionViewCell.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/9/21.
//

import UIKit
import Kingfisher

class ShowsCollectionViewCell: UICollectionViewCell {
    
    var showImageView: UIImageView!
    var addButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setting Up Views
    func setUpViews() {
        backgroundColor = .blue
        showImageView = Utilities.createImageView(image: "", contentMode: .scaleAspectFill)
        showImageView.layer.masksToBounds = true
        showImageView.layer.cornerRadius = 4
        
        addButton = Utilities.createButtonWithImage(name: "addIcon", backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), cornerRadius: 3, titleColor: .clear)
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = colorFromHexCode(hex: "#F1C40F").cgColor
        
        self.contentView.addSubview(showImageView)
        self.contentView.addSubview(addButton)
    }
    
    // MARK:- Setting Up Constraints
    func setUpConstraints() {
        showImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.width.height.equalTo(20)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showImageView.image = nil
    }
    
    //MARK:- Getting Color From HexCode
    func colorFromHexCode(hex: String) -> UIColor {
        let r, g, b, a: CGFloat
        
        var hexColor = hex
        
        if hex.hasPrefix("#") {
            hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            hexColor = hexColor.replacingOccurrences(of: "#", with: "")
        }
        
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                a = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x000000ff) / 255
                
                return UIColor(red: r, green: g, blue: b, alpha: a)
            }
        } else if (hexColor.count == 6) {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                b = CGFloat(hexNumber & 0x0000FF) / 255.0
                
                return UIColor(red: r, green: g, blue: b, alpha: 1.0)
            }
            
        }
        return .clear
    }
    //MARK:- Setting up the collectionViewCell
    func setUpCell (currentShow: Show) {
        let baseImageUrl = Utilities.sharedInstance.getBaseUrlForImage()
        if let safePosterPath = currentShow.poster_path {
        var stringUrlForImage = "\(baseImageUrl)\(safePosterPath)"
        print(stringUrlForImage)
        if let urlImageShow = URL(string: stringUrlForImage){
            showImageView.kf.setImage(with: urlImageShow, options: [.scaleFactor(UIScreen.main.scale), .transition(.flipFromBottom(0.1))])
        }
    }
    }
}
