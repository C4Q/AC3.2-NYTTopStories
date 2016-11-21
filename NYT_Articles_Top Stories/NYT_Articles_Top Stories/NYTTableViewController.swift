//
//  NYTTableViewController.swift
//  NYT_Articles_Top Stories
//
//  Created by John Gabriel Breshears on 11/20/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import UIKit

class NYTTableViewController: UITableViewController {
    
    var allNewsStuff: [NewsPaperParts] = []
    var NYTendPoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=44a2da0e2f3e49f99eb5ecb1aa923012"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableViewData()
        self.tableView.estimatedRowHeight = 200.0
        //self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadTableViewData(){
        APIRequestManager.manager.getData(endPoint: NYTendPoint) { (data: Data?) in
            guard let unwrappedData = data else {return}
            self.allNewsStuff = NewsPaperParts.buildNewsPaperPartsArray(from: unwrappedData)!
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        return allNewsStuff.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
        let thisNewsThing = allNewsStuff[indexPath.row]
        //cell.textLabel?.text = thisNewsThing.abstract
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let authorLabel = cell.viewWithTag(2) as! UILabel
        let abstractLabel = cell.viewWithTag(4) as! UILabel
        let dateLable = cell.viewWithTag(3) as! UILabel
        
        titleLabel.text = thisNewsThing.title
        authorLabel.text = thisNewsThing.byline
        dateLable.text = thisNewsThing.publishedDate
        abstractLabel.text = thisNewsThing.abstract

        return cell
    }
    
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let thisNewsThing = allNewsStuff[indexPath.row]
    let theURLINeed = thisNewsThing.url
    
    UIApplication.shared.open(theURLINeed, options: [:], completionHandler: nil)
    
    }
    
   /*
    let label = cell.viewWithTag(1000) as! UILabel
    if indexPath.row == 0 {
    label.text = row0text
    }else if indexPath.row == 1 {
    label.text = row1text
    }else if indexPath.row == 2 {
    label.text = row2text
    }else if indexPath.row == 3 {
    label.text = row3text
    }else if indexPath.row == 4 {
    label.text = row4text
*/
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
