//
//  HeaderTableView.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/10/21.
//

import UIKit
protocol HeaderTableViewDelegate {
    func seeAllShows(sectionName: String)
}
class HeaderTableView: UIView {
    
    var seeAllButton: UIButton!
    var headerTitleLabel: UILabel!
    var delegate: HeaderTableViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setting Up Views
    func setUpViews() {
        self.backgroundColor = .black
        seeAllButton = Utilities.createButton(title: "See all", backgroundColor: .clear, cornerRadius: 8, titleColor: .systemYellow)
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        headerTitleLabel = Utilities.createLabel(title: "", backgroundColor: .clear, cornerRadius: 0, textColor: .white, font: .boldSystemFont(ofSize: 17))
        
        self.addSubview(seeAllButton)
        self.addSubview(headerTitleLabel)
    }
    
    // MARK:- Setting Up Constraints
    func setUpConstraints() {
        headerTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
        }
        seeAllButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerTitleLabel)
            make.right.equalTo(self.snp.right).offset(-15)
        }
    }
    
    //MARK:- Setting up the headers of the sections
    func setUpHeaderSection (text: String) {
        headerTitleLabel.text = text
    }
    
    //MARK:- Sending the delegate function to the ShowsViewController
    @objc func seeAllButtonTapped() {
        self.delegate.seeAllShows(sectionName: headerTitleLabel.text ?? "")
    }
}
