//
//  ConnectorsView.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import UIKit
protocol ConnectorsViewDelegate {
    func showUpSignUpView()
    func showUpLoginView()
    func signInGoogleButtonTapped()
    func signInFacebookButtonTapped()
}
class ConnectorsView: UIView {
    
    var logInLabel: UILabel!
    var logInButton: UIButton!
    var fbLogInButton: UIButton!
    var googleLogInButton: UIButton!
    var betweenButtonsLabel: UILabel!
    var blurEffect: UIBlurEffect!
    var blurredEffectView: UIVisualEffectView!
    var noAccountLabel: UILabel!
    var signUpButton: UIButton!
    var delegate: ConnectorsViewDelegate!
    
    //MARK: - Initialization
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
        blurEffect = UIBlurEffect(style: .regular)
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.layer.cornerRadius = 20
        blurredEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurredEffectView.layer.masksToBounds = true
        
        logInLabel = Utilities.createLabel(title: "Login", backgroundColor: .clear, cornerRadius: 8, textColor: .white, font: .boldSystemFont(ofSize: 22))
        
        logInButton = Utilities.createButton(title: "Login", backgroundColor: .systemBlue, cornerRadius: 8, titleColor: .white)
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        betweenButtonsLabel = Utilities.createLabel(title: "Or, login with..", backgroundColor: .clear, cornerRadius: 8, textColor: .white, font: .systemFont(ofSize: 16))
        betweenButtonsLabel.textAlignment = .center
        
        fbLogInButton = Utilities.createButtonWithImage(name: "facebookicon", backgroundColor: .white, cornerRadius: 8, titleColor: .black)
        fbLogInButton.setTitle("Login with Facebook", for: .normal)
        fbLogInButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        fbLogInButton.contentMode = .scaleAspectFill
        fbLogInButton.imageEdgeInsets.left = -7
        fbLogInButton.addTarget(self, action: #selector(facebookButtonTapped), for: .touchUpInside)
        
        googleLogInButton = Utilities.createButtonWithImage(name: "googleicon", backgroundColor: .white, cornerRadius: 8, titleColor: .black)
        googleLogInButton.setTitle("Login with Google", for: .normal)
        googleLogInButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        googleLogInButton.contentMode = .scaleAspectFill
        googleLogInButton.imageEdgeInsets.left = -15
        googleLogInButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        
        noAccountLabel = Utilities.createLabel(title: "Don't have an account?", backgroundColor: .clear, cornerRadius: 8, textColor: .white, font: .systemFont(ofSize: 17))
        signUpButton = Utilities.createButton(title: "Sign up", backgroundColor: .clear, cornerRadius: 8, titleColor:.systemBlue)
        
        signUpButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        addSubview(blurredEffectView)
        addSubview(logInLabel)
        addSubview(logInButton)
        addSubview(fbLogInButton)
        addSubview(googleLogInButton)
        addSubview(betweenButtonsLabel)
        addSubview(noAccountLabel)
        addSubview(signUpButton)
    }
    
    // MARK:- Setting Up Constraints
    func setUpConstraints() {
        blurredEffectView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        logInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.left.equalTo(self).offset(15)
        }
        
        logInButton.snp.makeConstraints { (make) in
            make.top.equalTo(logInLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        betweenButtonsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logInButton.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.width.equalTo(150)
        }
        
        fbLogInButton.snp.makeConstraints { (make) in
            make.top.equalTo(logInButton.snp.bottom).offset(50)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        googleLogInButton.snp.makeConstraints { (make) in
            make.top.equalTo(fbLogInButton.snp.bottom).offset(8)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        noAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(googleLogInButton.snp.bottom).offset(10)
            make.centerX.equalTo(self).offset(-30)
        }
        
        signUpButton.snp.makeConstraints { (make) in
            make.left.equalTo(noAccountLabel.snp.right).offset(1)
            make.top.equalTo(googleLogInButton.snp.bottom).offset(3)
            make.width.equalTo(70)
        }
    }
    
    // MARK:- Buttons Actions
    @objc func buttonTapped() {
        self.delegate.showUpSignUpView()
    }
    
    @objc func logInButtonTapped() {
        self.delegate.showUpLoginView()
    }
    
    @objc func googleButtonTapped() {
        self.delegate.signInGoogleButtonTapped()
    }
    
    @objc func facebookButtonTapped() {
        self.delegate.signInFacebookButtonTapped()
    }
}
