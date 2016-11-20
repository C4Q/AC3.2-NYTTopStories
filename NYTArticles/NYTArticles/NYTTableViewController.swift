//
//  NYTTableViewController.swift
//  NYTArticles
//
//  Created by Annie Tung on 11/20/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

class NYTTableViewController: UITableViewController {
    
    var nyt: [NYT] = []
    var nytArticleEndPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=72e226bc6965459f95fc5290d492ca39"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
    }
    
    // MARK: - Method
    func displayData() {
        APIRequestManager.manager.getData(endPoint: nytArticleEndPoint) { (data: Data?) in
            guard let validData = data else { return }
            dump(validData)
            if let validNYT = NYT.parseData(from: validData) {
                self.nyt = validNYT
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nyt.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYTIdentifier", for: indexPath) as! NYTTableViewCell
        
        let ny = nyt[indexPath.row]
        cell.titleLabel.text = ny.title
        cell.byLabel.text = ny.byline
        cell.dateLabel.text = ny.publishedDate
        cell.summaryLabel.text = ny.summary
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: nyt[indexPath.row].url)!)
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
