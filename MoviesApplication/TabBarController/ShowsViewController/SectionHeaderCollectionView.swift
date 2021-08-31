//
//  SectionHeaderCollectionView.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/30/21.
//

import Foundation
import UIKit

class SectionHeaderCollectionView : UICollectionReusableView {
    var title: UILabel!
    
    // MARK:- Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setting up the views
    func setUpViews(){
        title = UILabel()
        title.font = .boldSystemFont(ofSize: 16)
        title.textColor = .white
        
        addSubview(title)
    }
    
    // MARK:- Setting up the constraints
    func setUpConstraints() {
        title.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(15)
        }
    }
    
    func setUpTheHeaderView(text: String) {
        title.text = text
    }
}
