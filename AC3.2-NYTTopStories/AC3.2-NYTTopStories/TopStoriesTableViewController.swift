//
//  TopStoriesTableViewController.swift
//  AC3.2-NYTTopStories
//
//  Created by Tom Seymour on 11/20/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class TopStoriesTableViewController: UITableViewController {
    
    let topStoryCellIdentifier = "topStoryCell"
    
    let nytApiKey = "bcbf953b87be45e3b353a7a7e7124b7c"
    let nytApiEndpointWithKey = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=bcbf953b87be45e3b353a7a7e7124b7c"
    
    var stories: [Story] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTopStories()
        navigationItem.title = "Home"
    }

    func loadTopStories() {
        APIHelper.manager.getData(endPoint: nytApiEndpointWithKey) { (data: Data?) in
            guard let unwrappedData = data else { return }
            self.stories = Story.buildTopStoryArray(from: unwrappedData)!
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
        return stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: topStoryCellIdentifier, for: indexPath) as! TopStoryTableViewCell
        let thisStory = stories[indexPath.row]
        cell.titleLabel.text = thisStory.title
        cell.bylineLabel.text = thisStory.byline
        cell.dateLabel.text = thisStory.date
        cell.abstractLabel.text = thisStory.abstract
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlStr = stories[indexPath.row].storyUrl
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
