//
//  signUpTableViewCell.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import UIKit
protocol SignUpTableViewCellDelegate {
    func getTextfieldType (type: TextfieldType, text: String)
    func goToNextTextField(type: TextfieldType)
}
class SignUpTableViewCell: UITableViewCell {
    
    var textField: UITextField!
    var iconImageView: UIImageView!
    var placeHolder: String!
    var imageIcon: String!
    var textFieldPlaceholder: String!
    var textFieldIcon: String!
    var textFieldPlaceHolder: String!
    var delegate: SignUpTableViewCellDelegate!
    var textFieldType: TextfieldType!
    var showPassButton: UIButton!
    
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
        textField.delegate = self
        
        iconImageView = Utilities.createImageView(image: "", contentMode: .scaleAspectFill)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.masksToBounds = true
        iconImageView.backgroundColor = .clear
        
        showPassButton = UIButton()
        showPassButton.setImage(UIImage(named: "passIcon"), for: .normal)
        showPassButton.addTarget(self, action: #selector(checkingVisibilityOfPassword), for: .touchUpInside)
        
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
    
    func setUpCell(textFieldIcon: String, textFieldPlaceHolder: String, type: TextfieldType){
        textFieldType = type
        iconImageView.image = UIImage(named: textFieldIcon)
        textField.placeholder = textFieldPlaceHolder
        if type == .Password {
            textField.isSecureTextEntry = true
            textField.rightView = showPassButton
            textField.rightViewMode = .always
        } else if type == .Email {
            textField.autocapitalizationType = .none
        }
    }
    
    @objc func checkingVisibilityOfPassword() {
        textField.isSecureTextEntry == true ? (textField.isSecureTextEntry = false) : (textField.isSecureTextEntry = true)
    }
}

extension SignUpTableViewCell : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.getTextfieldType(type: textFieldType, text: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate.goToNextTextField(type: textFieldType)
        return true
    }
}
