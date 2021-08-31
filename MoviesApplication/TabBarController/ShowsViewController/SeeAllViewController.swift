//
//  SeeAllViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/30/21.
//

import UIKit

class SeeAllViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var currentSectionName: String!
    var page = 1
    var arrayPopularShows = [Show]()
    var arrayAiringTodayShows = [Show]()
    var arrayOnTheAirShows = [Show]()
    var arrayTopRatedShows = [Show]()
    var shows = [Show]()
    var totalItems = 0
    var totalItemsPopular = 0
    var totalItemsAiringToday = 0
    var totalItemsOnTheAir = 0
    var totalItemsTopRated = 0
    
    // MARK:- Initialisation
    init(sectionName: String) {
        super.init(nibName: nil, bundle: nil)
        currentSectionName = sectionName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        getPopularShows(currentPage: 1)
        getAiringToday(currentPage: 1)
        getOnTheAirShows(currentPage: 1)
        getTopRatedMovies(currentPage: 1)
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Setting Up Views
    func setUpViews() {
        layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ShowsCollectionViewCell.self, forCellWithReuseIdentifier: "seeAllCell")
        collectionView.backgroundColor = .clear
        collectionView.register(SectionHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: "SectionHeader")
        
        self.view.addSubview(collectionView)
    }
    
    // MARK:- Setting Up Constraints
    func setUpConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func getCurrentCategoryShows () -> ShowsCategory {
        if currentSectionName == "Popular shows" {
            return .PopularShows
        } else if currentSectionName == "Airing Today" {
            return .AiringToday
        } else if currentSectionName == "On The Air Shows" {
            return .OnTheAirShows
        } else {
            return .TopRatedShows
        }
    }
    
    // MARK:- Getting respectively the array of shows of the clicked category
    func currentShowsToShow(showsCategory: ShowsCategory) -> [Show] {
        if showsCategory == .PopularShows {
            return arrayPopularShows
        } else if showsCategory == .AiringToday {
            return arrayAiringTodayShows
        } else if showsCategory == .OnTheAirShows {
            return arrayOnTheAirShows
        } else {
            return arrayTopRatedShows
        }
    }
    
    // MARK:- Doing respectively the call for the clicked category
    func apiCallForCategory(showsCategory: ShowsCategory, page: Int) {
        if showsCategory == .PopularShows {
            getPopularShows(currentPage: page)
        } else if showsCategory == .AiringToday {
            getAiringToday(currentPage: page)
        } else if showsCategory == .OnTheAirShows {
            getOnTheAirShows(currentPage: page)
        } else if showsCategory == .TopRatedShows {
            getTopRatedMovies(currentPage: page)
        }
    }
    
    // MARK:- Getting the number of total items of the clicked category
    func getCurrentTotalItems(showsCategory: ShowsCategory) -> Int {
        if showsCategory == .PopularShows {
            return totalItemsPopular
        } else if showsCategory == .AiringToday {
            return totalItemsAiringToday
        } else if showsCategory == .OnTheAirShows {
            return totalItemsOnTheAir
        } else {
            return totalItemsTopRated
        }
    }
}

// MARK:- CollectionView delegate functions
extension SeeAllViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shows = currentShowsToShow(showsCategory: getCurrentCategoryShows())
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seeAllCell", for: indexPath as IndexPath) as! ShowsCollectionViewCell
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 8
        cell.setUpCell(currentShow: shows[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        shows = currentShowsToShow(showsCategory: getCurrentCategoryShows())
        totalItems = getCurrentTotalItems(showsCategory: getCurrentCategoryShows())
        if shows.count < totalItems {
            if (indexPath.row == (shows.count - 1)) {
                page = page + 1
                apiCallForCategory(showsCategory: getCurrentCategoryShows(), page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width-30)/3, height: UIScreen.main.bounds.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeaderCollectionView {
            sectionHeader.setUpTheHeaderView(text: currentSectionName)
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

// MARK:- Api calls for every category of shows
extension SeeAllViewController {
    
    func getPopularShows(currentPage: Int) {
        ApiManager.sharedInstance.getPopularShows(page: currentPage) { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            print("arrayPopularShows: \(self.arrayPopularShows.count)")
                            print("safeshows: \(safeShows.count)")
                            self.arrayPopularShows.append(contentsOf: safeShows)
                        }
                    }
                }
                if let safeTotalResults = responseJson?["total_results"] as? Int {
                    self.totalItemsPopular = safeTotalResults
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(with: "Error with code \(statusCode)", message: nil)
            }
        }
    }
    
    func getAiringToday(currentPage: Int) {
        ApiManager.sharedInstance.getAiringToday(page: currentPage) { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            self.arrayAiringTodayShows.append(contentsOf: safeShows)
                        }
                    }
                }
                if let safeTotalResults = responseJson?["total_results"] as? Int {
                    self.totalItemsAiringToday = safeTotalResults
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(with: "Error with code \(statusCode)", message: nil)
            }
        }
    }
    
    func getOnTheAirShows(currentPage: Int) {
        ApiManager.sharedInstance.getOnTheAirShows(page: currentPage) { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            self.arrayOnTheAirShows.append(contentsOf: safeShows)
                        }
                    }
                }
                if let safeTotalResults = responseJson?["total_results"] as? Int {
                    self.totalItemsOnTheAir = safeTotalResults
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(with: "Error with code \(statusCode)", message: nil)
            }
        }
    }
    
    func getTopRatedMovies(currentPage: Int) {
        ApiManager.sharedInstance.getTopRatedShows(page: currentPage) { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            self.arrayTopRatedShows.append(contentsOf: safeShows)
                        }
                    }
                }
                if let safeTotalResults = responseJson?["total_results"] as? Int {
                    self.totalItemsTopRated = safeTotalResults
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(with: "Error with code \(statusCode)", message: nil)
            }
        }
    }
}
