//
//  ViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/19/21.
//
import UIKit
import SnapKit
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices


class WelcomeViewController: UIViewController {
    
    var backgroundImageView: UIImageView!
    var logInView: ConnectorsView!
    var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showLoginView), userInfo: nil, repeats: false)
    }
    // MARK:- Setting Up Views And Constraints
    func setUpViews() {
        backgroundImageView = Utilities.createImageView(image: "welcomeScreenBackground", contentMode: .scaleAspectFill)
        
        logInView = ConnectorsView()
        logInView.delegate = self
        signUpView = SignUpView()
        signUpView.delegate = self
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        logInView.googleLogInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
        
        
        logInView.layer.cornerRadius = 20
        logInView.layer.masksToBounds = true
        logInView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        signUpView.layer.cornerRadius = 20
        signUpView.layer.masksToBounds = true
        signUpView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(logInView)
        self.view.addSubview(signUpView)
        self.view.addGestureRecognizer(tap)
    }
    
    func setUpConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.snp.height)
        }
        
        logInView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom)
            make.width.equalTo(view)
            make.height.equalTo(view).dividedBy(2)
        }
        
        signUpView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.bottom)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).dividedBy(2)
        }
    }

        func presentAlertForSigningOut(){
            let alert = UIAlertController(title: "Logged in", message: "Please log out..", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Log out", style: .default, handler: { _ in
                GIDSignIn.sharedInstance()?.signOut()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    @objc func signInButtonTapped(_ sender: UIButton) {
            if (GIDSignIn.sharedInstance()?.currentUser != nil) {
                presentAlertForSigningOut()
            }
            else {
                GIDSignIn.sharedInstance()?.signIn()
            }
        }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func showLoginView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.logInView.snp.remakeConstraints { (make) in
                make.bottom.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(2)
            }
            self.view.layoutIfNeeded()
        })
    }
//    func showwwLoginView(){
//        UIView.animate(withDuration: 0.5, animations: {
//            self.logInView.snp.remakeConstraints { (make) in
//                make.bottom.equalTo(self.view.snp.bottom)
//                make.width.equalTo(self.view)
//                make.height.equalTo(self.view).dividedBy(2)
//            }
//            self.view.layoutIfNeeded()
//        })
//    }
    
    @objc func hideLoginView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.logInView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(2)
            }
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.showSignUpView()
        })
    }
    
    @objc func hideSignUpView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.signUpView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(2)
            }
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.showLoginView()
        })
    }
    
    func showSignUpView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.signUpView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.centerY)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(2)
            }
            self.view.layoutIfNeeded()
        })
    }
}

extension WelcomeViewController : ConnectorsViewDelegate {
    func showUpSignUpView() {
        hideLoginView()
        
    }
}
extension WelcomeViewController : SignUpViewDelegate {
    func returnToConnectorsView() {
        hideSignUpView()
    }
}

extension WelcomeViewController : LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let err = error {
            print(err.localizedDescription)
            return
        } else {
            self.getUserDataFromFacebook()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User logged out")
        
    }
    
    func getUserDataFromFacebook() {
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, picture, id"], tokenString: AccessToken.current?.tokenString, version: Settings.defaultGraphAPIVersion, httpMethod: HTTPMethod.get)
        
        graphRequest.start { (connection, result, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            } else {
//                if let fields = result as? [String:Any], let name = fields["first_name"] as? String, let lastname = fields["last_name"] as? String, let pictureDict = fields["picture"] as? [String : Any], let pictureData = pictureDict["data"] as? [String:Any], let picture = pictureData["url"] as? String, let userId = fields["id"] as? String
//                {
//                    self.user1 = User(dict: ["profilePicture" : picture])
//                    self.user1 = User(dict: ["id" : userId, "first_name" : name, "last_name" : lastname])
//
//                    KingfisherManager.shared.cache.clearMemoryCache()
//                    KingfisherManager.shared.cache.clearDiskCache()
//                    KingfisherManager.shared.cache.cleanExpiredDiskCache()
//                    if let url = URL(string: "https://graph.facebook.com/\(self.user1.id ?? "")/picture?type=large")
//                    {  fbImageView.kf.setImage(with: url, options: [.scaleFactor(UIScreen.main.scale), .transition(.flipFromBottom(0.1))])
//                    }
//                } else {
//                    print("An error occured: \(String(describing: error))")
//                }
            }
        }
    }
}
extension WelcomeViewController : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
//        if let firstName = user.profile.givenName, let lastName = user.profile.familyName, let eMail = user.profile.email, let profilePicture = user.profile.imageURL(withDimension: 300) {
//            self.user1 = User.init(dict: ["name" : firstName, "lastName" : lastName, "eMail" : eMail, "profilePicture" : profilePicture])
//            updateScreen()
//        }
    }
}


