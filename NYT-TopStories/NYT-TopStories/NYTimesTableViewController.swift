//
//  NYTimesTableViewController.swift
//  NYT-TopStories
//
//  Created by Harichandan Singh on 11/20/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class NYTimesTableViewController: UITableViewController, UITextFieldDelegate {
    //MARK: - Properties
    let endpoint: String = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=dad513f985cf4ad3b923fb9b3cae9eb0"
    internal var stories: [Story] = []
    var sectionDict = [String: Int]()
    internal var allStories: [Story] = []
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        navigationItem.title = "Home"
    }
    
    func loadData() {
        APIRequestManager.manager.getData(endpoint: endpoint) { (data: Data?) in
            if let stories = Story.turnDataIntoStoriesArray(data: data!) {
                self.allStories = stories
                self.stories = self.allStories
                self.updateSectionDictionary()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func applyPredicate(search: String) {
        let predicate = NSPredicate(format:"ANY per_facet CONTAINS[c] %@", search)
        self.stories = self.allStories.filter { predicate.evaluate(with: $0) }
        updateSectionDictionary()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func updateSectionDictionary() {
        self.sectionDict.removeAll()
        for story in self.stories {
            self.sectionDict[story.section] = (self.sectionDict[story.section] ?? 0) + 1
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionDict.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let key = self.sectionDict.keys.sorted()[section]
        return self.sectionDict[key] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYTCell", for: indexPath) as! TopStoriesTableViewCell
        
        let key = self.sectionDict.keys.sorted()[indexPath.section]
        let predicate = NSPredicate(format: "section = %@", key)
        let story = self.stories.filter { predicate.evaluate(with: $0) }[indexPath.row]
        
        cell.titleLabel.text = story.title
        cell.bylineLabel.text = story.byline
        cell.dateLabel.text = story.date
        cell.abstractTextView.text = story.abstract
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellIndexPath = stories[indexPath.row]
        let url: URL = URL(string: cellIndexPath.urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    //MARK: - Table view delegate 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = self.sectionDict.keys.sorted()[section]
        return key
    }
    
    //MARK: - Text Field Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            applyPredicate(search: text)
        }
        return true
    }
    
}
