//
//  ArticleTableViewController.swift
//  AC3.2-NYTTopStories
//
//  Created by Jason Gresh on 11/19/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController, UISearchBarDelegate {
    var allArticles = [Article]()
    var articles = [Article]()
    //var articleBySectionDict = [String: [Article]]()
    let defaultTitle = "Home"
    let endpointArr = ["home", "arts", "sports"]
    
    // I like keeping a separate "model" variable
    // but it would be have been an option to query the state of the switch
    var mergeSections = true
    
    var sectionTitles: [String] {
        get {
            var sectionSet = Set<String>()
            for article in articles {
                sectionSet.insert(article.section)
            }
            return Array(sectionSet).sorted()
        }
    }
    
    let identifier = "articleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.defaultTitle
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        for x in self.endpointArr {
            APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/\(x).json?api-key=f41c1b23419a4f55b613d0a243ed3243")  { (data: Data?) in
                if let validData = data {
                    if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                        if let wholeDict = jsonData as? [String:Any],
                            let records = wholeDict["results"] as? [[String:Any]] {
                 
                            self.allArticles.append(contentsOf:Article.parseArticles(from: records, apiSection: x))
                            // start off with everything
                            self.articles = self.allArticles
                            //self.articleBySectionDict[x] = Article.parseArticles(from: records)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if mergeSections {
            return self.sectionTitles.count
        } else {
            return endpointArr.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mergeSections {
            let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[section])
            return self.articles.filter { sectionPredicate.evaluate(with: $0)}.count
        } else {
            let sectionPredicate = NSPredicate(format: "apiSection = %@", self.endpointArr[section])
            return self.articles.filter { sectionPredicate.evaluate(with: $0)}.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ArticleTableViewCell
        
        if mergeSections {
            let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[indexPath.section])
            let article = self.articles.filter { sectionPredicate.evaluate(with: $0)}[indexPath.row]
            
            cell.titleLabel.text = article.title
            
            if article.per_facet.count > 0 {
                cell.abstractLabel.text = article.abstract + " " + article.per_facet.joined(separator: " ")
            }
            else {
                cell.abstractLabel.text = article.abstract
            }
            
            cell.bylineAndDateLabel.text = "\(article.byline)\n\(article.published_date)"
            
            return cell

        } else {
            let apiSectionPredicate = NSPredicate(format: "apiSection = %@", self.endpointArr[indexPath.section])
            let article = self.articles.filter { apiSectionPredicate.evaluate(with: $0) }[indexPath.row]
            cell.titleLabel.text = article.title
            // make a cell for the filtered sections home / sports / arts
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if mergeSections {
            return self.sectionTitles[section]
        } else {
            return self.endpointArr[section].capitalized
        }
    }
    
    func applyPredicate(search: String) {
        let predicate = NSPredicate(format:"title contains[c] %@ or abstract contains[c] %@ or ANY per_facet contains[c] %@ or ANY des_facet contains[c] %@ or ANY geo_facet contains[c] %@ or ANY org_facet contains[c] %@", search, search, search)
        
        self.articles = self.allArticles.filter { predicate.evaluate(with: $0) }
        self.tableView.reloadData()
    }
    
    func search(_ text: String) {
        if text.characters.count > 0 {
            applyPredicate(search: text)
            self.title = text
        }
        else {
            self.articles = self.allArticles
            self.tableView.reloadData()
            self.title = self.defaultTitle
        }
    }

    // MARK: - UISearchBar Delegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.search(text)
        }
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.search(text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.search("")
        searchBar.showsCancelButton = false
    }
    
    @IBAction func mergeSectionSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("Merge 3 api call together into sections found")
            self.mergeSections = true
        }
        else {
            print("Create sections based on the originating API endpoint")
            self.mergeSections = false
        }
        self.tableView.reloadData()
    }
}
