//
//  SignUpView.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import UIKit

protocol SignUpViewDelegate {
    func returnToConnectorsView()
    func getUserDataWith(type: TextfieldType, text: String)
    func checkEmptyTextFields()
}

class SignUpView: UIView {
    
    var tableView: UITableView!
    var registerLabel: UILabel!
    var signUpLabel: UILabel!
    var arrayOfPlaceholders = ["Email ID", "Password", "First name", "Last name"]
    var arrayOfIcons = ["mailIcon", "lockIcon", "userIcon", "userIcon"]
    var registerButton: UIButton!
    var blurEffect: UIBlurEffect!
    var blurredEffectView: UIVisualEffectView!
    var backToLoginButton: UIButton!
    var backToLoginLabel: UILabel!
    var delegate: SignUpViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Setting Up Views
    func setUpViews(){
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
        
        signUpLabel = Utilities.createLabel(title: "Sign Up", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        signUpLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        registerLabel = Utilities.createLabel(title: "Register with email..", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        registerLabel.textAlignment = .center
        
        registerButton = Utilities.createButton(title: "Register", backgroundColor: .systemBlue, cornerRadius: 8, titleColor: .white)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        backToLoginButton = Utilities.createButton(title: "Login", backgroundColor: .clear, cornerRadius: 8, titleColor: .systemBlue)
        backToLoginButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        
        backToLoginLabel = Utilities.createLabel(title: "Or go back to ", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        
        addSubview(blurredEffectView)
        addSubview(tableView)
        addSubview(registerLabel)
        addSubview(registerButton)
        addSubview(signUpLabel)
        addSubview(backToLoginButton)
        addSubview(backToLoginLabel)
    }
    
    // MARK:- Setting up Constraints
    func setUpConstraints(){
        blurredEffectView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        signUpLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(15)
        }
        
        registerLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(signUpLabel.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(registerLabel.snp.bottom).offset(10)
            make.bottom.equalTo(registerButton.snp.top)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-20)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(-65)
            make.height.equalTo(40)
        }
        
        backToLoginLabel.snp.makeConstraints { (make) in
            make.top.equalTo(registerButton.snp.bottom).offset(15)
            make.centerX.equalTo(self).offset(-20)
        }
        
        backToLoginButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(backToLoginLabel)
            make.left.equalTo(backToLoginLabel.snp.right).offset(2)
        }
    }
    
    @objc func logInButtonTapped() {
        self.delegate.returnToConnectorsView()
    }
    
    @objc func registerButtonTapped () {
        self.delegate.checkEmptyTextFields()
    }
    
    static func getTypeForTextField(row: Int) -> TextfieldType {
        if row == 0 {
            return .Email
        } else if row == 1 {
            return .Password
        } else if row == 2 {
            return .FirstName
        } else {
            return .LastName
        }
    }
    
    func changingActiveTextField(row: Int) {
        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? SignUpTableViewCell {
            cell.textField.becomeFirstResponder()
        }
        
    }
}

// MARK:- Delegate functions
extension SignUpView : UITableViewDelegate, UITableViewDataSource {
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

// MARK:- Delegate functions from SignUpTableViewCell
extension SignUpView : SignUpTableViewCellDelegate {
    
    func goToNextTextField(type: TextfieldType) {
        switch type {
        case .Email:
            changingActiveTextField(row: 1)
        case .Password:
            changingActiveTextField(row: 2)
        case .FirstName:
            changingActiveTextField(row: 3)
        case .LastName:
            self.endEditing(true)
        }
    }
    
    func getTextfieldType(type: TextfieldType, text: String) {
        if type == .Email {
            delegate.getUserDataWith(type: type, text: text)
        } else if type == .Password {
            delegate.getUserDataWith(type: type, text: text)
        } else if type == .FirstName {
            delegate.getUserDataWith(type: type, text: text)
        } else if type == .LastName {
            delegate.getUserDataWith(type: type, text: text)
        }
    }
}

