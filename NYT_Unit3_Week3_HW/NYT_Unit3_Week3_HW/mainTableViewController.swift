//
//  mainTableViewController.swift
//  NYT_Unit3_Week3_HW
//
//  Created by Thinley Dorjee on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class mainTableViewController: UITableViewController {

    var times = [Time]()
    let endPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=31ae7c06e3314e21b83c2b3846fe3f26"
    let tableViewCellIdentifier = "timesTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.title = "Home"
       
    }

    func loadData(){
        APIRequestManager.manager.getJsonData(endPoint: endPoint) { (data) in
            guard let validData = data else {return}
                self.times = Time.getTimeData(from: validData)!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
                
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? timesTableViewCell

        let thisCell = times[indexPath.row]
        
        cell?.titleLabel.text = thisCell.title
        cell?.bylineLabel.text = thisCell.byline
        cell?.dateLabel.text = thisCell.updated_date
        cell?.summaryLabel.text = thisCell.abstract

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: times[indexPath.row].url) else{return}
        UIApplication.shared.open(url)
    }

}
