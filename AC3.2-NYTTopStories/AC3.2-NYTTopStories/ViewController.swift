//
//  ViewController.swift
//  AC3.2-NYTTopStories
//
//  Created by Edward Anchundia on 11/20/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var nytTopStories: [NYTTopStories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.navigationItem.title = "Home"
    }
    
    func loadData() {
        APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=7d6e9521acc2476d8da86adf2151f540") { (data: Data?) in
            if data != nil {
                if let topStoriesData = NYTTopStories.getTopStories(from: data!) {
                    DispatchQueue.main.async {
                        self.nytTopStories = topStoriesData
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nytTopStories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopStoryCell", for: indexPath) as! TopStoriesTableViewCell
        let topStories = nytTopStories[indexPath.row]
        cell.titleLabel.text = topStories.title
        cell.dateLabel.text = topStories.byLine + "\n" + topStories.date
        cell.abstractLabel.text = topStories.abstract
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topStories = nytTopStories[indexPath.row]
        if let url = URL(string: topStories.url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}

