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
    var connectorsView: ConnectorsView!
    var signUpView: SignUpView!
    var logInView: LogInView!
    var logInViewFlag = false
    var connectorsViewFlag = false
    var signUpViewFlag = false
    var userInfo = UserInfo()
    var arrayUsers = [UserInfo]()
    var registeredUserFlag = false
    var loginMenager = LoginManager()
    var currentlyLoggedInUser = UserInfo()
    var googleLoggedIn = false
    static var facebookLoggedIn = false
    static var appLoggedIn = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showConnectorsView), userInfo: nil, repeats: false)
        
        decodeDataFromUserDefaults()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // MARK:- Setting Up Views And Constraints
    func setUpViews() {
        backgroundImageView = Utilities.createImageView(image: "welcomeScreenBackground", contentMode: .scaleAspectFill)
        
        connectorsView = ConnectorsView()
        connectorsView.delegate = self
        
        signUpView = SignUpView()
        signUpView.delegate = self
        
        logInView = LogInView()
        logInView.delegate = self
        
        logInView.layer.cornerRadius = 20
        logInView.layer.masksToBounds = true
        logInView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        connectorsView.googleLogInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
        
        connectorsView.layer.cornerRadius = 20
        connectorsView.layer.masksToBounds = true
        connectorsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        signUpView.layer.cornerRadius = 20
        signUpView.layer.masksToBounds = true
        signUpView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(connectorsView)
        self.view.addSubview(signUpView)
        self.view.addSubview(logInView)
        self.view.addGestureRecognizer(tap)
    }
    
    func setUpConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.snp.height)
        }
        
        connectorsView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom)
            make.width.equalTo(view)
            make.height.equalTo(self.view).dividedBy(2)
        }
        
        signUpView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.bottom)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).dividedBy(2)
            
        }
        
        logInView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.bottom)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).dividedBy(2)
        }
    }
    
    func getHeightResizeFactorForConnectorsView() -> Double {
        switch Utilities.sharedInstance.getIphoneType() {
        case .Small :
            return 2
        case .Medium :
            return 2.3
        case .Large :
            return 2.5
        case .XLarge :
            return 2.65
        case .MaxLarge :
            return 2.85
        }
    }
    
    func getHeightResizeFactorForLoginView() -> Double {
        switch Utilities.sharedInstance.getIphoneType() {
        case .Small :
            return 1.95
        case .Medium :
            return 2.25
        case .Large :
            return 2.55
        case .XLarge :
            return 2.72
        case .MaxLarge :
            return 2.9
        }
    }
    
    func getHeightResizeFactorForSignupView() -> Double {
        switch Utilities.sharedInstance.getIphoneType() {
        case .Small :
            return 1.4
        case .Medium :
            return 1.6
        case .Large :
            return 1.8
        case .XLarge :
            return 2
        case .MaxLarge :
            return 2.2
        }
    }
    // MARK:- Functions to showup and hide the keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (self.logInViewFlag == true) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.logInView.snp.remakeConstraints { (make) in
                        make.bottom.equalTo(self.view.snp.bottom).offset(-keyboardSize.height)
                        make.width.equalTo(self.view)
                        make.height.equalTo(self.view).dividedBy(self.getHeightResizeFactorForLoginView())
                    }
                    self.view.layoutIfNeeded()
                })
            }
            else if (self.signUpViewFlag == true) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.signUpView.snp.remakeConstraints { (make) in
                        make.bottom.equalTo(self.view.snp.bottom).offset(-keyboardSize.height)
                        make.width.equalTo(self.view)
                        make.height.equalTo(self.view).dividedBy(self.getHeightResizeFactorForSignupView())
                    }
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if (self.logInViewFlag == true) {
            UIView.animate(withDuration: 0.5, animations: {
                self.logInView.snp.remakeConstraints { (make) in
                    make.bottom.equalTo(self.view.snp.bottom)
                    make.width.equalTo(self.view)
                    make.height.equalTo(self.view).dividedBy(self.getHeightResizeFactorForLoginView())
                }
                self.view.layoutIfNeeded()
            })
        }
        else if (self.signUpViewFlag == true) {
            UIView.animate(withDuration: 0.5, animations: {
                self.signUpView.snp.remakeConstraints { (make) in
                    make.bottom.equalTo(self.view.snp.bottom)
                    make.width.equalTo(self.view)
                    make.height.equalTo(self.view).dividedBy(self.getHeightResizeFactorForSignupView())
                }
                self.view.layoutIfNeeded()
            })
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
    
    // MARK:- Functions for animating the subviews of WelcomeViewController
    @objc func showLogInView() {
        self.logInViewFlag = true
        UIView.animate(withDuration: 0.5, animations: {
            self.logInView.snp.remakeConstraints { (make) in
                //    make.top.equalTo(self.view.snp.centerY)
                make.bottom.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(self.getHeightResizeFactorForLoginView())
            }
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func hideLogInView() {
        self.logInViewFlag = false
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
    
    @objc func showConnectorsView() {
        self.connectorsViewFlag = true
        UIView.animate(withDuration: 0.5, animations: {
            self.connectorsView.snp.remakeConstraints { (make) in
                make.bottom.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(self.getHeightResizeFactorForConnectorsView())
            }
            self.view.layoutIfNeeded()
        })
    }
    func hideConnectorsView( viewType: WelcomeViewType) {
        self.connectorsViewFlag = false
        UIView.animate(withDuration: 0.5, animations: {
            self.connectorsView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(2)
            }
            self.view.layoutIfNeeded()
        }, completion: {_ in
            viewType == .logInView ? self.showLogInView() : self.showSignUpView()
        })
    }
    
    func showSignUpView() {
        self.signUpViewFlag = true
        UIView.animate(withDuration: 0.5, animations: {
            self.signUpView.snp.remakeConstraints { (make) in
                make.bottom.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(self.getHeightResizeFactorForSignupView())
            }
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func hideSignUpView() {
        self.signUpViewFlag = false
        UIView.animate(withDuration: 0.5, animations: {
            self.signUpView.snp.remakeConstraints { (make) in
                make.top.equalTo(self.view.snp.bottom)
                make.width.equalTo(self.view)
                make.height.equalTo(self.view).dividedBy(2)
            }
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.showConnectorsView()
        })
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkForEmptyDataForRegister (user: UserInfo) -> Bool {
        if ((user.email == "" || user.email == nil) || (user.password == "" || user.password == nil) || (user.firstName == "" || user.firstName == nil) || (user.lastName == "" || user.lastName == nil)) {
            return true
        }
        return false
    }
    
    func decodeDataFromUserDefaults() {
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
    // MARK:- Facebook Login implementation
    func facebookLogin() {
        let loginManager = LoginManager()
        loginManager.logOut()
        
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if (result!.isCancelled) {
                
            } else if ((result?.grantedPermissions.contains("email")) ?? false) {
                let request = GraphRequest(graphPath: "me", parameters: ["fields":"email,first_name,last_name,picture,id"], tokenString: AccessToken.current?.tokenString, version: nil, httpMethod: .get)
                request.start { (connection, result, error) in
                    if (error == nil) {
                        if let fields = result as? [String:Any], let name = fields["first_name"] as? String, let lastname = fields["last_name"] as? String, let email = fields["email"] as? String, let pictureDict = fields["picture"] as? [String : Any], let pictureData = pictureDict["data"] as? [String:Any], let picture = pictureData["url"] as? String, let userId = fields["id"] as? String {
                            self.currentlyLoggedInUser = UserInfo(email: email, password: "", firstName: name, lastName: lastname, profilePicture: nil, imageFbUrl: picture, imageGoogleUrl: nil, id: userId)
                            UserPersistence.sharedInstance.setFlagLoggedIn(flagUserLoggedIn: true)
                            self.navigationController?.pushViewController(TabBarController(), animated: true)
                            do {
                                let encoder = JSONEncoder()
                                let data = try encoder.encode(self.currentlyLoggedInUser)
                                UserPersistence.sharedInstance.setCurrrentActiveUser(currentUser: data)
                            } catch {
                                print("Unable to encode User info (\(error)")
                            }
                        } else {
                            print("An error occured: \(String(describing: error))")
                        }
                    }
                }
            } else {
                print("Failed")
            }
        }
    }
}

extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
// MARK:- Delegate functions from ConnectorsView
extension WelcomeViewController : ConnectorsViewDelegate {
    func signInFacebookButtonTapped() {
        facebookLogin()
    }
    
    func signInGoogleButtonTapped() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func showUpLoginView() {
        hideConnectorsView(viewType: .logInView)
    }
    
    func showUpSignUpView() {
        hideConnectorsView(viewType: .signUpView)
    }
}
// MARK:- Delegate functions from SignUpView
extension WelcomeViewController : SignUpViewDelegate {
    func checkEmptyTextFields() {
        if checkForEmptyDataForRegister(user: userInfo) {
            showAlert(with: "All fields are required.", message: nil)
        } else {
            for user in arrayUsers {
                if userInfo.email == user.email {
                    print("Already registered.")
                    showAlert(with: "Already registered.", message: nil)
                    registeredUserFlag = true
                    break
                }
            }
            if registeredUserFlag == false {
                do {
                    let encoder = JSONEncoder()
                    arrayUsers.append(userInfo)
                    let data = try encoder.encode(arrayUsers)
                    
                    UserPersistence.sharedInstance.setArrayUsers(arrayUsers: data)
                } catch {
                    print("Unable to encode User info (\(error)")
                }
            }
        }
    }
    
    func returnToConnectorsView() {
        hideSignUpView()
    }
    
    func getUserDataWith(type: TextfieldType, text: String) {
        if type == .Email {
            isValidEmail(text) ? userInfo.email = text : showAlert(with: "Error", message: "Wrong format for Email.")
        } else if type == .Password {
            userInfo.password = text
        } else if type == .FirstName {
            userInfo.firstName = text
        } else if type == .LastName {
            userInfo.lastName = text
        }
    }
}
// MARK:- Delegate functions from LogInView
extension WelcomeViewController : LogInViewDelegate {
    func goToSignUpView() {
        hideLogInView()
    }
    func getUserDataFromLoginWith(type: TextfieldType, text: String) {
        if type == .Email {
            isValidEmail(text) ? userInfo.email = text : showAlert(with: "Error", message: "Wrong format for Email.")
        } else if type == .Password {
            userInfo.password = text
        }
    }
    
    func checkEmptyTextFieldsFromLogin() {
        registeredUserFlag = false
        if ((userInfo.email == "" || userInfo.email == nil) || (userInfo.password == "" || userInfo.password == nil)) {
            showAlert(with: "All fields are required.", message: nil)
        } else {
            if let data = UserPersistence.sharedInstance.defaults.data(forKey: "arrayUsers")
            {
                do {
                    let decoder = JSONDecoder()
                    arrayUsers = try decoder.decode([UserInfo].self, from: data)
                    
                } catch {
                    print("Unable to decode Array of Users (\(error)")
                }
            }
            for user in arrayUsers {
                if ((userInfo.email == user.email) && (userInfo.password == user.password)) {
                    let encodedUser = Utilities.sharedInstance.encodeUserToData(user: user)
                    UserPersistence.sharedInstance.setCurrrentActiveUser(currentUser: encodedUser)
                    UserPersistence.sharedInstance.setFlagLoggedIn(flagUserLoggedIn: true)
                    self.navigationController?.pushViewController(TabBarController(), animated: true)
                    registeredUserFlag = true
                    break
                } else if ((userInfo.email != user.email) ^ (userInfo.password != user.password)) {
                    showAlert(with: "The email or password is incorrect.", message: nil)
                    break
                }
            }
            if registeredUserFlag == false {
                showAlert(with: "Not registered", message: "Please register first.")
            }
        }
    }
}
// MARK:- Google Login
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
        if let firstName = user.profile.givenName, let lastName = user.profile.familyName, let eMail = user.profile.email, let profilePicture = user.profile.imageURL(withDimension: 300) {
            self.currentlyLoggedInUser = UserInfo(email: eMail, password: "", firstName: firstName, lastName: lastName, profilePicture: nil, imageFbUrl: nil, imageGoogleUrl: profilePicture, id: nil)
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(self.currentlyLoggedInUser)
                UserPersistence.sharedInstance.setCurrrentActiveUser(currentUser: data)
                UserPersistence.sharedInstance.setFlagLoggedIn(flagUserLoggedIn: true)
                self.navigationController?.pushViewController(TabBarController(), animated: true)
            } catch {
                print("Unable to encode User info (\(error)")
            }
        }
        print("Successfully Logged in with Google.")
        
        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
    }
}

// MARK:- Notification names
extension Notification.Name {
    
    /// Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
}

