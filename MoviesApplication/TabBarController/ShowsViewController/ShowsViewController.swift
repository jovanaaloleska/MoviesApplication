//
//  ShowsViewController.swift
//  MoviesApplication
//
//  Created by Jovana Loleska on 8/4/21.
//

import UIKit

class ShowsViewController: UIViewController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Setting Up Views And Constraints
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
    
    func setUpConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

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
        return (self.view.frame.height)/3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0)
        {
            return "Popular shows"
        } else if (section == 1) {
            return "Airing today"
        } else if (section == 2) {
            return "Upcoming shows"
        } else if (section == 3) {
            return "Top rated shows"
        }
        return ""
    }
}
