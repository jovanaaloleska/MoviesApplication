//
//  AppDelegate.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 7/19/21.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        UserPersistence.sharedInstance.getCurrentActiveUser() == nil ? (navigationController = UINavigationController(rootViewController: WelcomeViewController())) : (navigationController = UINavigationController(rootViewController: TabBarController()))
//        navigationController.navigationBar.isHidden = true
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions:
                launchOptions
        )

        GIDSignIn.sharedInstance().clientID = "327874594939-plvnvrrvcsfusdmurbbuo2bs9t31grvf.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if ((GIDSignIn.sharedInstance()?.handle(url))!) {
            return (GIDSignIn.sharedInstance()?.handle(url))!
        } else if (ApplicationDelegate.shared.application(app, open: url, options: options)) {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return false
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

