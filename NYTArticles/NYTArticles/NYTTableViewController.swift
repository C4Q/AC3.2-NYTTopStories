//
//  NYTTableViewController.swift
//  NYTArticles
//
//  Created by Annie Tung on 11/20/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit

//Load other endpoints: (technology, science, arts, etc.) into the same section configuration. Re-organize the sections to have one section per API endpoint, again (technology, science, arts, etc.).

class NYTTableViewController: UITableViewController, UITextFieldDelegate {
    
    var nyt: [NYT] = [] // populating table
    var allnyt: [NYT] = []
    var nytArticleEndPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=72e226bc6965459f95fc5290d492ca39"
    let identifier = "NYTIdentifier"
    var sectionDict = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        self.navigationItem.title = "Home"
        self.tableView.rowHeight = 180
    }
    
    // MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.characters.count > 0 {
                applyPredicate(search: text)
            } else {
                self.nyt = self.allnyt
                updateSectionDictionary() // will be called when we need to update the articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        return true
    }
    
    // MARK: - Method
    func displayData() {
        APIRequestManager.manager.getData(endPoint: nytArticleEndPoint) { (data: Data?) in
            guard let validData = data else { return }
            dump(validData)
            if let validNYT = NYT.parseData(from: validData) {
                self.allnyt = validNYT
                self.nyt = self.allnyt
            }
            self.updateSectionDictionary()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func updateSectionDictionary() {
        self.sectionDict.removeAll()
        for article in self.nyt {
            self.sectionDict[article.section] = (self.sectionDict[article.section] ?? 0) + 1 // mapping the section to a dict, populate the dict
            // Looking for the articles in section and incrementing the counter
        }
    }
    
    func applyPredicate(search: String) {
        //let predicate = NSPredicate(format:"summary contains[c] %@ or title contains[c] %@", search, search)
        let predicate = NSPredicate(format:"ANY per_facet contains[c] %@", search) // Trump, Donald
        self.nyt = self.allnyt.filter { predicate.evaluate(with: $0) }
        updateSectionDictionary()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
 
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDict.count
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = self.sectionDict.keys.sorted()[section] // keys is the array of all keys from dict (section titles) -> sorted array by alphabet
        return self.sectionDict[key] ?? 0 // index into the array, key is how many articles has that section, this will give us the count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // filter our data into each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYTIdentifier", for: indexPath) as! NYTTableViewCell
        
        let key = self.sectionDict.keys.sorted()[indexPath.section]
        let predicate = NSPredicate(format: "section = %@", key) // predicate will search in data for key that will be title of section
        let article = self.nyt.filter { predicate.evaluate(with: $0) }[indexPath.row] // return an array
        
//        let ny = nyt[indexPath.row]
        cell.titleLabel.text = article.title
        cell.byLabel.text = article.byline
        cell.dateLabel.text = article.publishedDate
        cell.summaryLabel.text = article.summary + "PER: " + article.per_facet.joined(separator: " ")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = self.sectionDict.keys.sorted()[section]
        return key
    }
    
//    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: nyt[indexPath.row].url)!, options: [:], completionHandler: nil)
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
