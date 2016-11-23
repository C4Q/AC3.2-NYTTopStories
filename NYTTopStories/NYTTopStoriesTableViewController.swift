//
//  NYTTopStoriesTableViewController.swift
//  NYTTopStories
//
//  Created by Erica Y Stevens on 11/20/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

let section = "home"
let apiKey = "f41fed57c4b04ef5aed4b09b0bbc56b9"

class NYTTopStoriesTableViewController: UITableViewController {
    
    var nyTimesTopStories = [TopStory]()
    let cellIdentifier = "TopStoryCell"
    let nyTimesApiEndpoint = "http://api.nytimes.com/svc/topstories/v2/\(section).json?api-key=\(apiKey)"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = section.localizedCapitalized   

        APIRequestManager.manager.getData(endPoint: nyTimesApiEndpoint) { (data: Data?) in
            if let validData = data {
                
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []) {
                    if let jsonDict = jsonData as? [String:Any],
                        let topStoryResults = jsonDict["results"] as? [[String:Any]] {
                            self.nyTimesTopStories = TopStory.parseObjects(from: topStoryResults)
                        print(topStoryResults)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nyTimesTopStories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TopStoryTableViewCell

        // Configure the cell...
        let story = nyTimesTopStories[indexPath.row]
        
        cell.topStoryTitleLabel.text = story.title
        cell.topStoryByLineLabel.text = story.byLine
        cell.topStoryAbstractLabel.text = story.abstract
        cell.topStoryDatePublishedLabel.text = story.datePublished
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(nyTimesTopStories[indexPath.row].url)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
