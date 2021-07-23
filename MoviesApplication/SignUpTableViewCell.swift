//
//  signUpTableViewCell.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {
    
    var textField: UITextField!
    var iconImageView: UIImageView!
    var placeHolder: String!
    var imageIcon: String!
    var textFieldPlaceholder: String!
    var textFieldIcon: String!
    var textFieldPlaceHolder: String!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // MARK:- Setting Up Views And Constraints
    func setUpViews() {
        self.selectionStyle = .none
        textField = Utilities.createTextField(font: .systemFont(ofSize: 15), textColor: .black, placeHolder: "", backgroundColor: .clear, cornerRadius: 1, textAlignment: .left)
        
        iconImageView = Utilities.createImageView(image: "", contentMode: .scaleAspectFill)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.masksToBounds = true
        iconImageView.backgroundColor = .clear
        
        self.backgroundColor = .clear
        self.contentView.addSubview(textField)
        self.contentView.addSubview(iconImageView)
    }
    
    func setUpConstraints() {
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView).offset(-5)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalTo(textField)
            make.right.equalTo(textField.snp.left).offset(-5)
            make.width.height.equalTo(20)
        }
    }
    
    func setUpCell(textFieldIcon: String, textFieldPlaceHolder: String){
        iconImageView.image = UIImage(named: textFieldIcon)
        textField.placeholder = textFieldPlaceHolder
    }
}
