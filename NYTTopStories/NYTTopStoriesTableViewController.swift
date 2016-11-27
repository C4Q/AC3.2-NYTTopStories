//
//  NYTTopStoriesTableViewController.swift
//  NYTTopStories
//
//  Created by Karen Fuentes on 11/19/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class NYTTopStoriesTableViewController: UITableViewController{
    @IBOutlet weak var textfield: UITextField!
    var allTopStories = [NYTTopStories]()
    var article = [NYTTopStories]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "HOME"
        loadTopStories()
    }
    func loadTopStories(from APIkey: String = "68e34a2183664e988dcd1f73cc958f50") {
        let NYTTopStoriesEndPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(APIkey)"
        APIRequestManager.manager.getData(endPoint: NYTTopStoriesEndPoint) { (data: Data?) in
            if  let validData = data,
                let validTopStories = NYTTopStories.getNews(from: validData) {
                self.allTopStories = validTopStories
                let predicate = NSPredicate(format:"abstract contains[c] 'democrat'")
                self.article = self.allTopStories.filter { predicate.evaluate(with: $0) }
                dump(self.allTopStories)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
        return article.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topStoryCell", for: indexPath) as! NYTTopStoryTableViewCell
        cell.NYTTopStoryTitle.text = article[indexPath.row].title
        cell.NYTTopStoryByLine.text = article[indexPath.row].byLine
        cell.NYTTopStoryAbstract.text = article[indexPath.row].abstract
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: allTopStories[indexPath.row].url) else {return}
        UIApplication.shared.open(url)
        
    }
    
    func applyPredicate() {
        let predicate = NSPredicate(format:"abstract contains[c] 'democrat'")
        self.article = self.allTopStories.filter { predicate.evaluate(with: $0) }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    
    }
    // MARK: TextTField Delegate
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        if let text = textfield.text {
            applyPredicate()
        }
        return true
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
