//
//  SignUpView.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import UIKit

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Setting Up Views And Constraints
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
        
        backToLoginButton = Utilities.createButton(title: "Login", backgroundColor: .clear, cornerRadius: 8, titleColor: .systemBlue)
        backToLoginLabel = Utilities.createLabel(title: "Or go back to ", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        addSubview(blurredEffectView)
        addSubview(tableView)
        addSubview(registerLabel)
        addSubview(registerButton)
        addSubview(signUpLabel)
        addSubview(backToLoginButton)
        addSubview(backToLoginLabel)
    }
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
            make.top.equalTo(tableView.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self).offset(-80)
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
}
// MARK:- Delegate functions
extension SignUpView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfIcons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "signUpCell", for: indexPath) as! SignUpTableViewCell
        cell.setUpCell(textFieldIcon: arrayOfIcons[indexPath.row], textFieldPlaceHolder: arrayOfPlaceholders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
