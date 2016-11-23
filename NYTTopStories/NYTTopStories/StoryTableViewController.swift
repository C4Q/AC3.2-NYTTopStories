//
//  StoryTableViewController.swift
//  NYTTopStories
//
//  Created by Eashir Arafat on 11/20/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import UIKit

class StoryTableViewController: UITableViewController {

    var stories:[Story] = []
    var articleURLString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=3544f4d7480f47b8befc2446f096fb3f") { (data: Data?) in
            if let validData = data,
                let validStories = Story.getStories(from: validData) {
                self.stories = validStories
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as! StoryTableViewCell

        let story = stories[indexPath.row]
        
        cell.storyTitle.text = story.title
        cell.storySummary.text = story.summary
        cell.storyAuthor.text = story.author
        cell.storyDate.text = story.date

        return cell
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        
        let story = stories[indexPath.row]
        
        articleURLString = story.shortUrl
        
        guard let unwrappedArticleURLString = articleURLString else { return }
        
        let articleURL: URL = URL(string: unwrappedArticleURLString)!
        UIApplication.shared.open(articleURL, options: [:], completionHandler: nil)
        
    }
    

    

}
