//
//  ProfileViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/4/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profilePictureImageView: UIImageView!
    var selectProfilePictureButton: UIButton!
    var nameLabel: UILabel!
    var mailLabel: UILabel!
    var signOutButton: UIButton!
    var user = UserInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemOrange
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    func setUpViews() {
        profilePictureImageView = UIImageView()
        profilePictureImageView.backgroundColor = .white
        
        selectProfilePictureButton = UIButton()
        selectProfilePictureButton.setImage(UIImage(named: "cameraIcon"), for: .normal)
        selectProfilePictureButton.backgroundColor = .systemYellow
        
        nameLabel = UILabel()
        if let userFirstName = user.firstName, let userLastName = user.lastName {
        nameLabel.text = "\(userFirstName) \(userLastName)"
        nameLabel.textColor = .white
        }
        
        mailLabel = UILabel()
        if let userMail = user.email {
        mailLabel.text = "\(userMail)"
        mailLabel.textColor = .white
        }
        
        signOutButton = UIButton()
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.backgroundColor = .systemYellow
        signOutButton.layer.cornerRadius = 8
        
        view.addSubview(profilePictureImageView)
        view.addSubview(selectProfilePictureButton)
        view.addSubview(nameLabel)
        view.addSubview(mailLabel)
        view.addSubview(signOutButton)
        
    }
    
    func setUpConstraints() {
        profilePictureImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
            make.height.width.equalTo(50)
        }
        selectProfilePictureButton.snp.makeConstraints { (make) in
            make.top.equalTo(profilePictureImageView.snp.bottom)
            make.centerX.equalTo(profilePictureImageView).offset(25)
            make.width.height.equalTo(20)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profilePictureImageView.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }
        mailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalTo(view).offset(20)
            make.centerX.equalTo(nameLabel)
        }
        signOutButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-95)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
    }

}
