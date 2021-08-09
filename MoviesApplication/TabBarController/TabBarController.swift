//
//  NavigationTabBarController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/4/21.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showsViewController = ShowsViewController()
        let moviesViewController = MoviesViewController()
        let discoverViewController = DiscoverViewController()
        
        let showsIcon = UITabBarItem(title: "Shows", image: UIImage(named: "tvshowIcon"), selectedImage: UIImage(named: "tvshowIcon"))
        let moviesIcon = UITabBarItem(title: "Movies", image: UIImage(named: "movieIcon"), selectedImage: UIImage(named: "movieIcon"))
        let discoverIcon = UITabBarItem(title: "Discover", image: UIImage(named: "searchIcon"), selectedImage: UIImage(named: "searchIcon"))
        let profileIcon = UITabBarItem(title: "Profile", image: UIImage(named: "IconUser"), selectedImage: UIImage(named: "IconUser"))
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        
        showsViewController.tabBarItem = showsIcon
        moviesViewController.tabBarItem = moviesIcon
        discoverViewController.tabBarItem = discoverIcon
        profileViewController.tabBarItem = profileIcon
        
        let controllers = [showsViewController, moviesViewController, discoverViewController, profileViewController]
        self.viewControllers = controllers
        self.tabBar.tintColor = .white
        //self.tabBar.backgroundColor = .yellow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}
