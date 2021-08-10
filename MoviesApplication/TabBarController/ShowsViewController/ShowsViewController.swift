//
//  ShowsViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/4/21.
//

import UIKit

class ShowsViewController: UIViewController {
    
    var tableView: UITableView!
    var sectionsTitles = ["Popular shows", "Airing Today", "Upcoming shows", "Top rated shows"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
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
}

// MARK:- UITableView, UITableViewDataSource delegate functions
extension ShowsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showsTableCell", for: indexPath) as! ShowsTableViewCell
        cell.backgroundColor = .clear
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
        var headerView = HeaderTableView()
        headerView.setUpHeaderSection(text: sectionsTitles[section])
        return headerView
    }
}

extension ShowsViewController : HeaderTableViewDelegate {
    func seeAllShows() {
        
    }
}
