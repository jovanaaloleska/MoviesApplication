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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    func setUpViews() {
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "welcomeScreenBackground")
        
        self.view.addSubview(backgroundImageView)
    }
    
    func setUpConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.snp.height)
        }
    }
}

