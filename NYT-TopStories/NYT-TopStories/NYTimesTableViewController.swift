//
//  NYTimesTableViewController.swift
//  NYT-TopStories
//
//  Created by Harichandan Singh on 11/20/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class NYTimesTableViewController: UITableViewController {
    //MARK: - Properties
    let endpoint: String = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=dad513f985cf4ad3b923fb9b3cae9eb0"
    internal var stories: [Story] = []
    
    //MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        navigationItem.title = "Home"
    }
    
    func loadData() {
        APIRequestManager.manager.getData(endpoint: endpoint) { (data: Data?) in
            if let stories = Story.turnDataIntoStoriesArray(data: data!) {
                self.stories = stories
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYTCell", for: indexPath) as? TopStoriesTableViewCell
        let cellIndexPath = stories[indexPath.row]
        
        cell?.titleLabel.text = cellIndexPath.title
        cell?.bylineLabel.text = cellIndexPath.byline
        cell?.dateLabel.text = cellIndexPath.date
        cell?.abstractTextView.text = cellIndexPath.abstract
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellIndexPath = stories[indexPath.row]
        let url: URL = URL(string: cellIndexPath.urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    

}
