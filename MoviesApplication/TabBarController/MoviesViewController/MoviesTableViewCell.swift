//
//  MoviesTableCell.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/10/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var moviesBackgrounds = ["bojackHorseman", "dark", "emilyInParis", "laCasaDePapel", "lupin", "outerBanks", "peakyBlinders", "strangerThings", "theCrown", "theWitcher"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setting Up Views
    func setUpViews() {
        layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: "moviesCollectionViewCell")
        collectionView.backgroundColor = .clear
        
        self.contentView.addSubview(collectionView)
    }
    
    // MARK:- Setting Up Constraints
    func setUpConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

// MARK:- CollectionView delegate functions
extension MoviesTableViewCell :  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-30)/2.5, height: self.frame.height-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesBackgrounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionViewCell", for: indexPath as IndexPath) as! MoviesCollectionViewCell
        cell.backgroundColor = UIColor.clear // make cell more visible in our example project
        cell.layer.cornerRadius = 8
        cell.setUpCell(showBackground: moviesBackgrounds[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
