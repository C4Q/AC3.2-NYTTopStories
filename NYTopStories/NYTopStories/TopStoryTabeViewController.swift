//
//  ViewController.swift
//  NYTopStories
//
//  Created by Ilmira Estil on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class TopStoryTableViewController: UITableViewController {
    let endpoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=a1ff01962b4e463eb3b9e182cafcce59"
    
    private let api = APIManager.manager
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }
    
    func loadData() {
        api.getData(endPoint: endpoint) { (data: Data?) in
            guard let unwrappedData = data else { return }
            if let allArticles = Article.articles(from: unwrappedData) {
                self.articles = allArticles
            } else { return }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        if let artCell = cell as? ArticleTableViewCell {
            let sCell = articles[indexPath.row]
        
        artCell.articleTitle?.text = sCell.title
        artCell.articleAuthor?.text = sCell.byline
        artCell.datePublished?.text = sCell.publishedDate
        artCell.articleSummary?.text = sCell.abstract
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sCell = articles[indexPath.row]
        guard let url = URL(string: sCell.articleURL) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //http://stackoverflow.com/questions/37231463/tableviewcell-open-url-on-click-swift
    }
}

