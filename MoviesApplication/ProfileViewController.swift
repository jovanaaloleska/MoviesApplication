//
//  ProfileViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/4/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var topView: UIView!
    var profilePictureImageView: UIImageView!
    var selectProfilePictureButton: UIButton!
    var nameLabel: UILabel!
    var mailLabel: UILabel!
    var signOutButton: UIButton!
    var editProfileLabel: UILabel!
    var user: UserInfo!
    var imagePicker = UIImagePickerController()
    var profileImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        decodeDataToUser(data: UserPersistence.sharedInstance.getCurrentActiveUser())
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        
        topView = UIView()
        topView.backgroundColor = .systemYellow
        
        editProfileLabel = UILabel()
        editProfileLabel.text = "Profile"
        editProfileLabel.textColor = .white
        editProfileLabel.font = .boldSystemFont(ofSize: 25)
        
        selectProfilePictureButton = UIButton()
        selectProfilePictureButton.setImage(UIImage(named: "cameraIcon"), for: .normal)
        selectProfilePictureButton.backgroundColor = .systemYellow
        selectProfilePictureButton.layer.cornerRadius = 8
        selectProfilePictureButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        nameLabel = UILabel()
        if let firstName = user.firstName, let lastName = user.lastName {
            nameLabel.text = "\(firstName) \(lastName)"
        }
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 19)
        
        mailLabel = UILabel()
        
        if let email = user.email {
            mailLabel.text = "\(email)"
        }
        mailLabel.textColor = .white
        mailLabel.font = .boldSystemFont(ofSize: 17)
        
        signOutButton = UIButton()
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.backgroundColor = .systemYellow
        signOutButton.layer.cornerRadius = 5
        
        profilePictureImageView = UIImageView()
        profilePictureImageView.backgroundColor = .white
        profilePictureImageView.layer.cornerRadius = 80
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.borderWidth = 5.0
        profilePictureImageView.contentMode = .scaleAspectFill
        
        if let profileImage = user.profilePicture {
            profilePictureImageView.image = UIImage(data: profileImage)
        }
        
        imagePicker.delegate = self
        
        view.addSubview(profilePictureImageView)
        view.addSubview(selectProfilePictureButton)
        view.addSubview(nameLabel)
        view.addSubview(mailLabel)
        view.addSubview(signOutButton)
        view.addSubview(topView)
        view.addSubview(editProfileLabel)
    }
    
    func setUpConstraints() {
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.height.equalTo(130)
            make.width.equalTo(view)
        }
        editProfileLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(topView.snp.bottom).offset(-25)
            make.left.equalTo(view).offset(50)
        }
        profilePictureImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(50)
            make.centerX.equalTo(view)
            make.height.width.equalTo(160)
        }
        selectProfilePictureButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(profilePictureImageView.snp.bottom).offset(-18)
            make.right.equalTo(profilePictureImageView.snp.right).offset(-18)
            make.width.height.equalTo(25)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profilePictureImageView.snp.bottom).offset(70)
            make.centerX.equalTo(view)
        }
        mailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.centerX.equalTo(view)
        }
        signOutButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-120)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    func decodeDataToUser(data: Data?) {
        guard let userdata = data else { return }
        do {
            let decoder = JSONDecoder()
            user = try decoder.decode(UserInfo.self, from: userdata)
            
        } catch {
            print("Unable to decode Array of Users (\(error)")
        }
    }
    
    @objc func showActionSheet() {
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertSheet.addAction(UIAlertAction(title: "Select from gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        alertSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: {_ in
            self.openCamera()
        }))
        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertSheet, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let tempImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage = tempImage
        }
        profilePictureImageView.image = profileImage
        user.profilePicture = Utilities.sharedInstance.encodingToData(source: profileImage)
        UserPersistence.sharedInstance.setCurrrentActiveUser(currentUser:  Utilities.sharedInstance.encodeUserToData(user: user))
        
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
