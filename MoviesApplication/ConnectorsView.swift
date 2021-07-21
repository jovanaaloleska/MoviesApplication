//
//  ConnectorsView.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/20/21.
//

import UIKit

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
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Setting Up Views And Constraints
    func setUpViews() {
        blurEffect = UIBlurEffect(style: .regular)
        blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.layer.cornerRadius = 20
        blurredEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurredEffectView.layer.masksToBounds = true
        
        logInLabel = Utilities.createLabel(title: "Login", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        logInLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        logInButton = Utilities.createButton(title: "Login", backgroundColor: .systemBlue, cornerRadius: 8, titleColor: .white)
        logInButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        betweenButtonsLabel = Utilities.createLabel(title: "Or, login with..", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        betweenButtonsLabel.textAlignment = .center
        
        fbLogInButton = UIButton()
        fbLogInButton.setImage(UIImage(named: "facebookicon"), for: .normal)
        fbLogInButton.setTitle("Login with Facebook", for: .normal)
        fbLogInButton.setTitleColor(.black, for: .normal)
        fbLogInButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        fbLogInButton.backgroundColor = .white
        fbLogInButton.layer.cornerRadius = 8
        fbLogInButton.contentMode = .scaleAspectFill
        fbLogInButton.imageEdgeInsets.left = -7
        
        googleLogInButton = UIButton()
        googleLogInButton.setImage(UIImage(named: "googleicon"), for: .normal)
        googleLogInButton.setTitle("Login with Google", for: .normal)
        googleLogInButton.setTitleColor(.black, for: .normal)
        googleLogInButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        googleLogInButton.backgroundColor = .white
        googleLogInButton.layer.cornerRadius = 8
        googleLogInButton.contentMode = .scaleAspectFill
        googleLogInButton.imageEdgeInsets.left = -15

        noAccountLabel = Utilities.createLabel(title: "Don't have an account?", backgroundColor: .clear, cornerRadius: 8, textColor: .white)
        signUpButton = Utilities.createButton(title: "Sign up", backgroundColor: .clear, cornerRadius: 8, titleColor:.systemBlue)
        
        addSubview(blurredEffectView)
        addSubview(logInLabel)
        addSubview(logInButton)
        addSubview(fbLogInButton)
        addSubview(googleLogInButton)
        addSubview(betweenButtonsLabel)
        addSubview(noAccountLabel)
        addSubview(signUpButton)
    }
    
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
            //     make.centerY.equalTo(self).offset(-50)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            
        }
        betweenButtonsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logInButton.snp.bottom).offset(15)
            make.centerX.equalTo(self)
            make.width.equalTo(150)
        }
        fbLogInButton.snp.makeConstraints { (make) in
            make.top.equalTo(logInButton.snp.bottom).offset(50)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        googleLogInButton.snp.makeConstraints { (make) in
            make.top.equalTo(fbLogInButton.snp.bottom).offset(8)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            
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
    
    @objc func buttonTapped() {
        
    }
}
