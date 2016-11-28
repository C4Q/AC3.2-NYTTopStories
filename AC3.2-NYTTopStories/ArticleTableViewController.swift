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
    let defaultTitle = "Home"
    
    let sectionNamesArray = ["Arts", "Home", "Sports"]
    var homeArticles: [Article] = []
    var artArticles: [Article] = []
    var sportsArticles: [Article] = []
    
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
        loadArrays()
        
        //        APIRequestManager.manager.getData(section: "")  { (data: Data?) in
        //            if let validData = data {
        //                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
        //                    if let wholeDict = jsonData as? [String:Any],
        //                        let records = wholeDict["results"] as? [[String:Any]] {
        //                        self.allArticles = Article.parseArticles(from: records)
        //
        //                        // start off with everything
        //                        self.articles = self.allArticles
        //                        DispatchQueue.main.async {
        //                            self.tableView.reloadData()
        //                        }
        //                    }
        //                }
        //            }
        //        }
    }
    
    func loadArrays() {
        APIRequestManager.manager.getData(section: "home")  { (data: Data?) in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                    if let wholeDict = jsonData as? [String:Any],
                        let records = wholeDict["results"] as? [[String:Any]] {
                        self.allArticles.append(contentsOf:Article.parseArticles(from: records))
                        self.homeArticles.append(contentsOf: Article.parseArticles(from: records))
                        
                        // start off with everything
                        self.articles = self.allArticles
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
        APIRequestManager.manager.getData(section: "arts")  { (data: Data?) in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                    if let wholeDict = jsonData as? [String:Any],
                        let records = wholeDict["results"] as? [[String:Any]] {
                        self.allArticles.append(contentsOf:Article.parseArticles(from: records))
                        self.artArticles.append(contentsOf: Article.parseArticles(from: records))
                        
                        // start off with everything
                        self.articles = self.allArticles
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
        APIRequestManager.manager.getData(section: "sports")  { (data: Data?) in
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options:[]) {
                    if let wholeDict = jsonData as? [String:Any],
                        let records = wholeDict["results"] as? [[String:Any]] {
                        self.allArticles.append(contentsOf:Article.parseArticles(from: records))
                        self.sportsArticles.append(contentsOf: Article.parseArticles(from: records))
                        
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
        //return self.sectionTitles.count
        
        if mergeSections {
            return self.sectionNamesArray.count
        } else {
            return self.sectionTitles.count
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[section])
        //        return self.articles.filter { sectionPredicate.evaluate(with: $0)}.count
        
        if mergeSections {
            switch self.sectionNamesArray[section] {
            case "Home":
                return self.homeArticles.count
            case "Sports":
                return self.sportsArticles.count
            case "Arts":
                return self.artArticles.count
            default:
                return 0
            }
        } else {
            let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[section])
            return self.articles.filter { sectionPredicate.evaluate(with: $0)}.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ArticleTableViewCell
        
        //        let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[indexPath.section])
        //        let article = self.articles.filter { sectionPredicate.evaluate(with: $0)}[indexPath.row]
        //
        //        cell.titleLabel.text = article.title
        //
        //        if article.per_facet.count > 0 {
        //          cell.abstractLabel.text = article.abstract + " " + article.per_facet.joined(separator: " ")
        //        }
        //        else {
        //            cell.abstractLabel.text = article.abstract
        //        }
        //
        //        cell.bylineAndDateLabel.text = "\(article.byline)\n\(article.published_date)"
        
        if mergeSections {
            switch sectionNamesArray[indexPath.section] {
            case "Home":
                let article = self.homeArticles[indexPath.row]
                cell.abstractLabel.text = article.abstract
                cell.bylineAndDateLabel.text = "\(article.byline)\n\(article.published_date)"
            case "Sports":
                let article = self.sportsArticles[indexPath.row]
                cell.abstractLabel.text = article.abstract
                cell.bylineAndDateLabel.text = "\(article.byline)\n\(article.published_date)"
            case "Arts":
                let article = self.artArticles[indexPath.row]
                cell.abstractLabel.text = article.abstract
                cell.bylineAndDateLabel.text = "\(article.byline)\n\(article.published_date)"
            default:
                cell.abstractLabel.text = " "
                cell.bylineAndDateLabel.text = " "
            }
        } else {
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
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if mergeSections {
            return self.sectionNamesArray[section]
        } else {
            return self.sectionTitles[section]
        }
    }
    
    func applyPredicate(search: String) {
        let titlePredicate = NSPredicate(format: "title CONTAINS[c] %@", search, search, search)
        let abstractPredicate = NSPredicate(format: "abstract CONTAINS[c] %@", search, search, search)
        let perfacetPredicate = NSPredicate(format:"ANY per_facet CONTAINS[c] %@", search, search, search)
        let desfacetPredicate = NSPredicate(format: "ANY des_facet CONTAINS[c] %@", search, search, search)
        let geofacetPredicate = NSPredicate(format: "ANY geo_facet CONTAINS[c] %@", search, search, search)
        let orgfacetPredicate = NSPredicate(format: "ANY org_facet CONTAINS[c] %@", search, search, search)
        
        let compoundPredicate: NSCompoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, abstractPredicate, perfacetPredicate, desfacetPredicate, geofacetPredicate, orgfacetPredicate])
        
        if mergeSections {
            self.articles = self.homeArticles.filter { compoundPredicate.evaluate(with: $0) }
            self.articles.append(contentsOf: homeArticles.filter {  compoundPredicate.evaluate(with: $0) })
            self.articles.append(contentsOf: sportsArticles.filter { compoundPredicate.evaluate(with: $0) })
        }
        else {
            self.articles = self.allArticles.filter { compoundPredicate.evaluate(with: $0) }
        }
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
