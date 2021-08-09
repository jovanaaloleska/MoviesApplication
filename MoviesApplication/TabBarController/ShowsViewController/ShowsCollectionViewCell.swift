//
//  ShowsCollectionViewCell.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/9/21.
//

import UIKit

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
    
    func setUpViews() {
        showImageView = UIImageView()
        showImageView.contentMode = .scaleAspectFill
        showImageView.layer.masksToBounds = true
        
        addButton = UIButton()
        addButton.layer.cornerRadius = 8
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
                                                            UIBlurEffect.Style.light))
        blur.frame = addButton.bounds
        blur.isUserInteractionEnabled = false //This allows touches to forward to the button.
        addButton.insertSubview(blur, at: 0)
        addButton.setImage(UIImage(named: "addIcon"), for: .normal)
        
        self.contentView.addSubview(showImageView)
        self.contentView.addSubview(addButton)
    }
    
    func setUpConstraints() {
        showImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.width.height.equalTo(50)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showImageView.image = UIImage(named: "")
    }
    
    func setUpCell (showBackground: String) {
        showImageView.image = UIImage(named: showBackground)
    }
}
