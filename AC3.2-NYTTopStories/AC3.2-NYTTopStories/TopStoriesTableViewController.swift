//
//  TopStoriesTableViewController.swift
//  AC3.2-NYTTopStories
//
//  Created by Madushani Lekam Wasam Liyanage on 11/19/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class TopStoriesTableViewController: UITableViewController {
    
    let topStoriesAPIEndPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=b54e8d92c64b4623a973f5f38fcd1ad4"
    
    var topStories: [TopStory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NYT Top Stories"
        
        APIRequestManager.manager.getData(endPoint: topStoriesAPIEndPoint) { (data: Data?) in
            if  let validData = data,
                let validStories = TopStory.getTopStories(from: validData) {
                self.topStories = validStories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topStories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = topStories[indexPath.row].url
        
        if let url = URL(string: urlString) {
            
            UIApplication.shared.open(url)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopStoryCellIdentifier", for: indexPath) as! TopStoryTableViewCell
        
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell.titleLabel.text = topStories[indexPath.row].title
        cell.dateLabel.text = topStories[indexPath.row].date
        cell.bylineLabel.text = topStories[indexPath.row].byline
        cell.abstractLabel.text = topStories[indexPath.row].abstract
        
        return cell
    }
    
}
