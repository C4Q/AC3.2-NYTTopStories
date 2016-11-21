//
//  TopStoriesTableViewController.swift
//  TopStoriesV2
//
//  Created by Cris on 11/20/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

class TopStoriesTableViewController: UITableViewController {
    
    var objects = [Stories]()

    let APIURL = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=c895e9726a3e48229ef6321a4b0c532a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getData(APIURlSring: APIURL) { (data: Data?) in
            if let validData = data,
                let validObjects = Stories.object(from: validData) {
                self.objects = validObjects
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StoryCell(style: UITableViewCellStyle.default, reuseIdentifier: StoryCell.identifier)
        let story = objects[indexPath.row]
        cell.storyTitle.text = story.storyTitle
        cell.storyByLine.text = story.storyByLine
        cell.storyAbstract.text = story.storyAbstrct
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = objects[indexPath.row]

        guard let url = URL(string: story.storyURlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
}
