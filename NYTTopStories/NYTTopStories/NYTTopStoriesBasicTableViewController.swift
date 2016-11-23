//
//  NYTTopStoriesBasicTableViewController.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class NYTTopStoriesBasicTableViewController: UITableViewController, UISearchBarDelegate {
    
    var storyObjectArr = [Story]()
    var storyObjectArrFiltered = [Story]()
    var sectionDict = [String:Int]()
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        self.title = "Top Stories"
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        APIRequestManager.manager.getData(endpoint: Story.endpoint){(data:Data?) in
            if data != nil {
                dump(data!)
                if let validStory = Story.generateStory(from: data!) {
                    self.storyObjectArr = validStory
                    self.storyObjectArrFiltered = validStory
                    self.updateSectionDictionary()
                    dump(self.storyObjectArr)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func createSearchBar() {
        let searchbar = UISearchBar()
        searchbar.showsCancelButton = false
        searchbar.placeholder = "Enter title to search"
        searchbar.delegate = self
        self.navigationItem.titleView = searchbar
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
//        let predicate = NSPredicate(format: "abstract contains[c] %@ or title contains[c] %@", searchTerm)
        let predicate = NSPredicate(format: "ANY per_facet contains[c] %@", searchTerm) //Trump, Donald J
        self.storyObjectArrFiltered = self.storyObjectArr.filter{predicate.evaluate(with: $0)}
        self.updateSectionDictionary()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDict.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.sectionDict.keys.sorted()[section]
        return self.sectionDict[key] ?? 0
        //        return storyObjectArrFiltered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicStoryCellIdentifier" , for: indexPath) as! BasicStoryCell
        
        let key = self.sectionDict.keys.sorted()[indexPath.section]
        let predicate = NSPredicate(format: "section = %@", key)
        let story = self.storyObjectArrFiltered.filter{predicate.evaluate(with: $0)}[indexPath.row]
        
        //let story = storyObjectArrFiltered[indexPath.row]
        self.tableView.rowHeight = screenSize.height * 0.28
        
        let attributedString = NSMutableAttributedString(string: story.title, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)])
        let attributedDescription = NSMutableAttributedString(string: "\n\n" + story.byline + "\n" + story.created_date + "\n" + story.abstract, attributes: [NSForegroundColorAttributeName:UIColor.lightGray, NSFontAttributeName:UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)])
        attributedString.append(attributedDescription)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let textLength = attributedString.string.characters.count
        let range = NSRange(location: 0, length: textLength)
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        cell.storyTextView.attributedText = attributedString
        cell.storyTextView.isUserInteractionEnabled = false
        updateSectionDictionary()
        return cell
    }
    
    func updateSectionDictionary() {
        self.sectionDict.removeAll()
        for article in self.storyObjectArrFiltered {
            //Use ternary operator
            self.sectionDict[article.section] = (self.sectionDict[article.section] ?? 0) + 1
        }
    }
    
//    func applyPredicate(search: String) {
//        //let predicate = NSPredicate(format:"abstract contains[c] %@ or title contains[c] %@", search, search)
//        let predicate = NSPredicate(format:"ANY per_facet contains[c] %@", search) // Trump, Donald J
//        
//        self.storyObjectArrFiltered = self.storyObjectArr.filter { predicate.evaluate(with: $0) }
//        updateSectionDictionary()
//        self.tableView.reloadData()
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) Selected" )
        let selectedStory = self.storyObjectArr[indexPath.row]
        guard let validURL = URL(string: selectedStory.url) else {return}
        UIApplication.shared.open(validURL, options: [:], completionHandler: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = self.sectionDict.keys.sorted()[section]
        return key
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 72
    //    }
    
}

/* From Instructor Jason
import UIKit

class ArticleTableViewController: UITableViewController, UITextFieldDelegate {
    var allArticles = [Article]()
    var articles = [Article]()
    let identifier = "articleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=f41c1b23419a4f55b613d0a243ed3243")  { (data: Data?) in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                    if let wholeDict = jsonData as? [String:Any],
                        let records = wholeDict["results"] as? [[String:Any]] {
                        self.allArticles = Article.parseArticles(from: records)
                        
                        // start off with everything
                        self.articles = self.allArticles
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
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
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ArticleTableViewCell
        let article = articles[indexPath.row]
        
        cell.titleLabel.text = article.title
        cell.abstractLabel.text = article.abstract + "PER: " + article.per_facet.joined(separator: " ")
        cell.bylineAndDateLabel.text = "\(article.byline)\n\(article.published_date)"
        
        return cell
    }
    
    func applyPredicate(search: String) {
        //let predicate = NSPredicate(format:"abstract contains[c] %@ or title contains[c] %@", search, search)
        let predicate = NSPredicate(format:"ANY per_facet contains[c] %@", search) // Trump, Donald J
        
        self.articles = self.allArticles.filter { predicate.evaluate(with: $0) }
    updateSectionDictionary()
        self.tableView.reloadData()
    }
    
    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.characters.count > 0 {
                applyPredicate(search: text)
            }
            else {
                self.articles = self.allArticles
                self.tableView.reloadData()
            }
        }
        return true
    }
}
*/
 

