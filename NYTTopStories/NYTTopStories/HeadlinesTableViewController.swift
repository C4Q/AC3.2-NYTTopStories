//
//  HeadlinesTableViewController.swift
//  NYTTopStories
//
//  Created by Sabrina Ip on 11/20/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class HeadlinesTableViewController: UITableViewController {

    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        ApiRequestManager.manager.getData(from: Article.nytTopStoriesUrl) { (data) in
            if let validData = data {
                self.articles = Article.getJson(from: validData)
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: articles[indexPath.row].urlString) else { return }
        /* Citation for the following line http://useyourloaf.com/blog/openurl-deprecated-in-ios10/ */
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
