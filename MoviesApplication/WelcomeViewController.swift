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
    var logInView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    func setUpViews() {
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "welcomeScreenBackground")
        
        logInView = UIView()
        if !UIAccessibility.isReduceTransparencyEnabled{
            logInView.backgroundColor = .clear
            
            let blurrEffect = UIBlurEffect(style: .dark)
            logInView = UIVisualEffectView(effect: blurrEffect)
        } else {
            logInView.backgroundColor = .black
        }
        
        logInView.layer.cornerRadius = 20
        logInView.layer.masksToBounds = true
        logInView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        

        self.view.addSubview(backgroundImageView)
        self.view.addSubview(logInView)
    }
    
    func setUpConstraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(self.view.snp.height)
        }
        logInView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.centerY)
            make.width.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

