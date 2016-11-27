//
//  NYTTopArticlesTableViewController.swift
//  NYT Top Articles
//
//  Created by Marcel Chaucer on 11/19/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class NYTTopArticlesTableViewController: UITableViewController, UITextFieldDelegate {
    var endPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=6d66a003ed60484fa93d1520540c1517"
    var allArticles: [TopArticle] = []
    var articles: [TopArticle] = []
    var searchWord = "trump"
    var sectionDict = [String: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppRequestManager.Manager.getData(endPoint: endPoint) { (data: Data?) in
            if  let validData = data,
                let validInfo = TopArticle.get(topArticle: validData) {
                self.allArticles = validInfo
                let predicate = NSPredicate(format:"abstract contains[c] '\(self.searchWord)'")
                self.articles = self.allArticles.filter { predicate.evaluate(with: $0)}
                self.updateSectionDictionary()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    self.tableView.estimatedRowHeight = 200.0
                }
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleDetail", for: indexPath) as! NYTArticleTableViewCell
        
        let key = self.sectionDict.keys.sorted()[indexPath.section]
        let predicate = NSPredicate(format: "section = %@", key)
        let oneArticle = self.articles.filter { predicate.evaluate(with: $0) }[indexPath.row]
        updateSectionDictionary()
      //  let oneArticle = self.articles[indexPath.row]
       
        cell.abstractLabel.text = oneArticle.abstract
        cell.titleLabel.text = oneArticle.title
        cell.byLineLabel.text = oneArticle.byLine
        cell.dateLabel.text = "Created: \(oneArticle.date.components(separatedBy: "T")[0])"
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = self.sectionDict.keys.sorted()[section]
        return key
    }
    
    func updateSectionDictionary() {
        self.sectionDict.removeAll()
        for article in self.articles {
            self.sectionDict[article.section] = (self.sectionDict[article.section] ?? 0) + 1
        }
    }
    
  
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let allText = textField.text {
            self.searchWord = allText
        }
        textField.text = nil
        let predicate = NSPredicate(format:"abstract contains[c] '\(self.searchWord)'")
        self.articles = self.allArticles.filter { predicate.evaluate(with: $0)}
        updateSectionDictionary()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        return true
    }
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        UIApplication.shared.open(self.articles[indexPath.row].url, options: [:], completionHandler: nil)
    }
}
