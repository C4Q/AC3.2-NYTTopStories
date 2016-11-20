//
//  NYTTopArticlesTableViewController.swift
//  NYT Top Articles
//
//  Created by Marcel Chaucer on 11/19/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class NYTTopArticlesTableViewController: UITableViewController {
    var endPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=6d66a003ed60484fa93d1520540c1517"
    var Articles: [TopArticle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppRequestManager.Manager.getData(endPoint: endPoint) { (data: Data?) in
                if  let validData = data,
                    let validInfo = TopArticle.get(topArticle: validData)                {
                    self.Articles = validInfo
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.tableView.rowHeight = UITableViewAutomaticDimension
                        self.tableView.estimatedRowHeight = 200.0
                        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
                        self.navigationController?.title = "Home"

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
        return Articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleDetail", for: indexPath) as! NYTArticleTableViewCell
        let oneArticle = Articles[indexPath.row]
       
        cell.abstractLabel.text = oneArticle.abstract
        cell.titleLabel.text = oneArticle.title
        cell.byLineLabel.text = oneArticle.byLine
        cell.dateLabel.text = "Created: \(oneArticle.date.components(separatedBy: "T")[0])"
       
        return cell
    }
    
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        UIApplication.shared.open(Articles[indexPath.row].url, options: [:], completionHandler: nil)
    }

    
}
