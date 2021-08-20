//
//  ShowsViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/4/21.
//

import UIKit
import Alamofire

class ShowsViewController: UIViewController {
    
    var tableView: UITableView!
    var sectionsTitles = ["Popular shows", "Airing Today", "Latest shows", "Top rated shows"]
    var arrayPopularShows = [Show]()
    var arrayAiringTodayShows = [Show]()
    var arrayLatestShows = [Show]()
    var arrayTopRatedShows = [Show]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        getPopularShows()
        getAiringToday()
        getOnTheAirShows()
        getTopRatedMovies()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Setting Up Views
    func setUpViews() {
        view.backgroundColor = UIColor.black
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShowsTableViewCell.self, forCellReuseIdentifier: "showsTableCell")
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
    }
    
    // MARK:- Setting Up Constraints
    func setUpConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func getShowsForSection(section: Int) -> [Show]
    {
        if section == 0 {
            return arrayPopularShows
        } else if section == 1 {
            return arrayAiringTodayShows
        } else if section == 2 {
            return arrayLatestShows
        } else if section == 3 {
            return arrayTopRatedShows
        }
        return []
    }
}

// MARK:- UITableView, UITableViewDataSource delegate functions
extension ShowsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showsTableCell", for: indexPath) as! ShowsTableViewCell
        cell.backgroundColor = .clear
        let test = getShowsForSection(section: indexPath.section)
        print(test)
        cell.getArraysForShows(array: getShowsForSection(section: indexPath.section))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.width)/1.7
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .gray
            headerView.backgroundView?.backgroundColor = .darkGray
            headerView.textLabel?.textColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderTableView()
        headerView.setUpHeaderSection(text: sectionsTitles[section])
        return headerView
    }
}

extension ShowsViewController : HeaderTableViewDelegate {
    func seeAllShows() {
    }
}

extension ShowsViewController {
    
    func getPopularShows() {
        ApiManager.sharedInstance.getPopularShows { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            self.arrayPopularShows = safeShows
                        }
                    }
                } else {
                    self.showAlert(with: "Error with code \(statusCode)", message: nil)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getAiringToday() {
        ApiManager.sharedInstance.getAiringToday { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            self.arrayAiringTodayShows = safeShows
                        }
                    }
                } else {
                    self.showAlert(with: "Error with code \(statusCode)", message: nil)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getOnTheAirShows() {
        ApiManager.sharedInstance.getOnTheAirShows { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            self.arrayLatestShows = safeShows
                        }
                    }
                } else {
                    self.showAlert(with: "Error with code \(statusCode)", message: nil)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getTopRatedMovies() {
        ApiManager.sharedInstance.getTopRatedShows { (success, responseJson, statusCode) in
            if success {
                if let safeJson = responseJson?["results"] as? [[String:Any]] {
                    if let safeData = Utilities.sharedInstance.jsonToData(json: safeJson){
                        let decoder = JSONDecoder()
                        let shows = try? decoder.decode([Show].self, from: safeData)
                        if let safeShows = shows {
                            self.arrayTopRatedShows = safeShows
                        }
                    }
                } else {
                    self.showAlert(with: "Error with code \(statusCode)", message: nil)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}




