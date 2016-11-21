//
//  HeadlinesTableViewController.swift
//  NYTTopStories
//
//  Created by Sabrina Ip on 11/20/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class HeadlinesTableViewController: UITableViewController, UITextFieldDelegate {
    
    var allArticles = [Article]()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        ApiRequestManager.manager.getData(from: Article.nytTopStoriesUrl) { (data) in
            if let validData = data {
                self.allArticles = Article.getJson(from: validData)
                self.articles = self.allArticles
                DispatchQueue.main.async {
                    /* Citation - The following two lines were inspired from http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights */
                    self.tableView.rowHeight = UITableViewAutomaticDimension
                    self.tableView.estimatedRowHeight = 170
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Article Cell", for: indexPath) as! HeadlinesTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        
        /* Only adds byline or date if they contain text */
        var byLineAndDateText = ""
        func addToBylineAndDateText(text: String) {
            if text == "" { return }
            if byLineAndDateText == "" {
                byLineAndDateText += text
            } else {
                byLineAndDateText += "\n\(text)"
            }
        }
        addToBylineAndDateText(text: article.byline)
        addToBylineAndDateText(text: article.publishedDate)
        
        cell.bylineAndDateLabel.text = byLineAndDateText
        cell.abstractLabel.text = article.abstract
        
        if article.perFacet.count > 0 {
            cell.abstractLabel.text = "\(article.abstract)\n\nPER: \(article.perFacet.joined(separator: "; "))"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: articles[indexPath.row].urlString) else { return }
        /* Citation for the following line http://useyourloaf.com/blog/openurl-deprecated-in-ios10/ */
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func applyPredicate(search: String) {
        //let predicate = NSPredicate(format:"abstract contains[c] %@ or title contains[c] %@", search, search)
        let predicate = NSPredicate(format:"ANY perFacet contains[c] %@", search) // Trump, Donald J
        self.articles = self.allArticles.filter { predicate.evaluate(with: $0) }
        self.tableView.reloadData()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.characters.count > 0 {
                applyPredicate(search: text)
            } else {
                self.articles = self.allArticles
                self.tableView.reloadData()
            }
        }
        return true
    }
}
