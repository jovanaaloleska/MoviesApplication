//
//  ViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/19/21.
//
import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    var backgroundImageView: UIImageView!
    var logInView: ConnectorsView!
    var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    // MARK:- Setting Up Views And Constraints
    func setUpViews() {
        backgroundImageView = Utilities.createImageView(image: "welcomeScreenBackground", contentMode: .scaleToFill)
        
        logInView = ConnectorsView()
        signUpView = SignUpView()
        
        logInView.layer.cornerRadius = 20
        logInView.layer.masksToBounds = true
        logInView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        signUpView.layer.cornerRadius = 20
        signUpView.layer.masksToBounds = true
        signUpView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.view.addSubview(backgroundImageView)
//        self.view.addSubview(logInView)
        self.view.addSubview(signUpView)
        self.view.addGestureRecognizer(tap)
    }
    
    func setUpConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.snp.height)
        }
//        logInView.snp.makeConstraints { (make) in
//            make.top.equalTo(view.snp.centerY)
//            make.width.equalTo(view)
//            make.bottom.equalTo(view.snp.bottom)
//        }
        signUpView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(120)
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}



