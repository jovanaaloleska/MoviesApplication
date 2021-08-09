//
//  ProfileViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/4/21.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    var profilePictureImageView: UIImageView!
    var selectProfilePictureButton: UIButton!
    var nameLabel: UILabel!
    var mailLabel: UILabel!
    var signOutButton: UIButton!
    var editProfileLabel: UILabel!
    var user = UserInfo()
    var imagePicker = UIImagePickerController()
    var profileImage = UIImage()
    var arrayUsers = [UserInfo]()
    var counterUsers = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeDataToUser(data: UserPersistence.sharedInstance.getCurrentActiveUser())
        setUpViews()
        setUpConstraints()
        setUpNavigation()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Setting Up Views
    func setUpViews() {
        view.backgroundColor = .black
        
        editProfileLabel = Utilities.createLabel(title: "My Profile", backgroundColor: .clear, cornerRadius: 0, textColor: .white)
        editProfileLabel.font = .boldSystemFont(ofSize: 25)
        
        selectProfilePictureButton = Utilities.createButton(title: "", backgroundColor: .systemYellow, cornerRadius: 8, titleColor: .clear)
        selectProfilePictureButton.setImage(UIImage(named: "cameraIcon"), for: .normal)
        selectProfilePictureButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        nameLabel = Utilities.createLabel(title: "", backgroundColor: .clear, cornerRadius: 0, textColor: .white)
        if let firstName = user.firstName, let lastName = user.lastName {
            nameLabel.text = "\(firstName) \(lastName)"
        }
        nameLabel.font = .boldSystemFont(ofSize: 19)
        
        mailLabel = Utilities.createLabel(title: "", backgroundColor: .clear, cornerRadius: 0, textColor: .white)
        if let email = user.email {
            mailLabel.text = "\(email)"
        }
        mailLabel.font = .boldSystemFont(ofSize: 17)
        
        signOutButton = Utilities.createButton(title: "Sign Out", backgroundColor: .systemYellow, cornerRadius: 5, titleColor: .white)
        signOutButton.addTarget(self, action: #selector(signingOut), for: .touchUpInside)
        
        profilePictureImageView = Utilities.createImageView(image: "", contentMode: .scaleAspectFill)
        profilePictureImageView.backgroundColor = .white
        profilePictureImageView.layer.cornerRadius = 80
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.borderWidth = 5.0
        
        if let profileImage = user.profilePicture {
            profilePictureImageView.image = UIImage(data: profileImage)
        }
        if let profileFbImage = user.imageFbUrl {
            print(profileFbImage)
            if let url = URL(string: "https://graph.facebook.com/\(self.user.id ?? "")/picture?type=large"){
                profilePictureImageView.kf.setImage(with: url, options: [.scaleFactor(UIScreen.main.scale), .transition(.flipFromBottom(0.1))])
            }
        }
        if let profileGoogleImage = user.imageGoogleUrl {
            profilePictureImageView.kf.setImage(with: profileGoogleImage, options: [.scaleFactor(UIScreen.main.scale), .transition(.flipFromBottom(0.1))])
        }
        
        imagePicker.delegate = self
        
        view.addSubview(profilePictureImageView)
        view.addSubview(selectProfilePictureButton)
        view.addSubview(nameLabel)
        view.addSubview(mailLabel)
        view.addSubview(signOutButton)
        view.addSubview(editProfileLabel)
    }
    
    // MARK:- Setting Up Constraints
    func setUpConstraints() {
        profilePictureImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(150)
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
    
    // MARK:- SetUp Navigation
    func setUpNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Profile"
    }
    
    @objc func signingOut() {
        UserPersistence.sharedInstance.setFlagLoggedIn(flagUserLoggedIn: false)
        self.navigationController?.pushViewController(WelcomeViewController(), animated: true)
    }
    
    // MARK:- Image picker implementation
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
    
    // MARK:- Decoding data functions
    func decodeDataToUser(data: Data?) {
        guard let userdata = data else { return }
        do {
            let decoder = JSONDecoder()
            user = try decoder.decode(UserInfo.self, from: userdata)
            
        } catch {
            print("Unable to decode Array of Users (\(error)")
        }
    }
    
    func decodeDataForUserArrayFromUserDefaults() {
        if let data = UserPersistence.sharedInstance.defaults.data(forKey: "arrayUsers")
        {
            do {
                let decoder = JSONDecoder()
                arrayUsers = try decoder.decode([UserInfo].self, from: data)
                
            } catch {
                print("Unable to decode Array of Users (\(error)")
            }
        }
    }
    
}

// MARK:- UIImagePickerController, UINavigationController delegate methods
extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let tempImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage = tempImage
        }
        profilePictureImageView.image = profileImage
        user.profilePicture = Utilities.sharedInstance.encodingToData(source: profileImage)
        // setting the updated user
        UserPersistence.sharedInstance.setCurrrentActiveUser(currentUser:  Utilities.sharedInstance.encodeUserToData(user: user))
        // addding the new updated user to the array
        decodeDataForUserArrayFromUserDefaults()
        for userInfo in arrayUsers {
            if ((user.email == userInfo.email) && (user.password == userInfo.password)) {
                // let encodedUser = Utilities.sharedInstance.encodeUserToData(user: user)
                //     UserPersistence.sharedInstance.setCurrrentActiveUser(currentUser: encodedUser)
                if let safeData = UserPersistence.sharedInstance.getCurrentActiveUser(){
                    decodeDataToUser(data: safeData)
                    arrayUsers.remove(at: counterUsers)
                    arrayUsers.append(user)
                    do {
                        let encoder = JSONEncoder()
                        let data = try encoder.encode(arrayUsers)
                        UserPersistence.sharedInstance.setArrayUsers(arrayUsers: data)
                    } catch {
                        print("Unable to encode User info (\(error)")
                    }
                }
                break
            } else if ((userInfo.email != user.email) ^ (userInfo.password != user.password)) {
                showAlert(with: "The email or password is incorrect.", message: nil)
                break
            }
            counterUsers += 1
        }
        counterUsers = 0
        
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
