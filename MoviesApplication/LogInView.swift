//
//  LogInView.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import UIKit

protocol LogInViewDelegate {
    func goToSignUpView()
    func getUserDataFromLoginWith(type: TextfieldType, text: String)
    func checkEmptyTextFieldsFromLogin()
}
class LogInView: UIView {
    
    var tableView: UITableView!
    var blurEffect: UIBlurEffect!
    var blurredEffectView: UIVisualEffectView!
    var logInLabel: UILabel!
    var arrayOfPlaceholders = ["Email ID", "Password"]
    var arrayOfIcons = ["mailIcon", "lockIcon"]
    var logInButton: UIButton!
    var forgotPasswordButton: UIButton!
    var registerLabel: UILabel!
    var registerButton: UIButton!
    var delegate: LogInViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        blurEffect = UIBlurEffect(style: .regular)
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.layer.cornerRadius = 20
        blurredEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurredEffectView.layer.masksToBounds = true
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SignUpTableViewCell.self, forCellReuseIdentifier: "signUpCell")
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        forgotPasswordButton = Utilities.createButton(title: "Forgot?", backgroundColor: .clear, cornerRadius: 8, titleColor: .systemBlue)
        
        logInLabel = Utilities.createLabel(title: "Login", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        logInLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        logInButton = Utilities.createButton(title: "Login", backgroundColor: .systemBlue, cornerRadius: 8, titleColor: .white)
        logInButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        registerLabel = Utilities.createLabel(title: "New to MoviesApp? ", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        
        registerButton = Utilities.createButton(title: "Register", backgroundColor: .clear, cornerRadius: 8, titleColor: .systemBlue)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        self.addSubview(blurredEffectView)
        self.addSubview(tableView)
        self.addSubview(forgotPasswordButton)
        self.addSubview(logInLabel)
        self.addSubview(logInButton)
        self.addSubview(registerLabel)
        self.addSubview(registerButton)
    }
    func setUpConstraints(){
        blurredEffectView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        logInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(15)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(logInLabel.snp.bottom).offset(20)
            make.bottom.equalTo(registerButton.snp.top)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-20)
        }
        
        logInButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(17)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-75)
            make.height.equalTo(40)
        }
        
        registerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logInButton.snp.bottom).offset(15)
            make.centerX.equalTo(self).offset(-20)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(registerLabel)
            make.left.equalTo(registerLabel.snp.right).offset(2)
        }
    }
    
    @objc func registerButtonTapped(){
        self.delegate.goToSignUpView()
    }
    
    @objc func loginButtonTapped() {
        self.delegate.checkEmptyTextFieldsFromLogin()
    }
    
}
// MARK:- Delegate functions
extension LogInView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfIcons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signUpCell", for: indexPath) as! SignUpTableViewCell
        cell.delegate = self
        cell.setUpCell(textFieldIcon: arrayOfIcons[indexPath.row], textFieldPlaceHolder: arrayOfPlaceholders[indexPath.row], type: SignUpView.getTypeForTextField(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
extension LogInView : SignUpTableViewCellDelegate {
    func goToNextTextField(type: TextfieldType) {
        switch type {
        case .Email:
            if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? SignUpTableViewCell {
                        cell.textField.becomeFirstResponder()
                    }
        case .Password:
                self.endEditing(true)
        default:
            break
        }
    }
    
    func getTextfieldType(type: TextfieldType, text: String) {
        if type == .Email {
            delegate.getUserDataFromLoginWith(type: type, text: text)
        } else if type == .Password {
            delegate.getUserDataFromLoginWith(type: type, text: text)
        }
    }
}
