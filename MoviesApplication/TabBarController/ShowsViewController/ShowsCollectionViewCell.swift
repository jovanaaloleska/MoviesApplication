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
    
    // MARK:- Initialisation
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
        addButton.layer.borderColor = Utilities.sharedInstance.colorFromHexCode(hex: "#F1C40F").cgColor
        
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
    
    //MARK:- Setting up the collectionViewCell
    func setUpCell (currentShow: Show) {
        let baseImageUrl = Utilities.sharedInstance.getBaseUrlForImage()
        if let safePosterPath = currentShow.poster_path {
            let stringUrlForImage = "\(baseImageUrl)\(safePosterPath)"
            if let urlImageShow = URL(string: stringUrlForImage){
                showImageView.kf.setImage(with: urlImageShow, options: [.scaleFactor(UIScreen.main.scale), .transition(.flipFromBottom(0.1))])
            }
        }
    }
}
