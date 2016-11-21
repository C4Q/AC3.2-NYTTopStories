//
//  NYTTopStoriesBasicTableViewController.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class NYTTopStoriesBasicTableViewController: UITableViewController {
    
    var storyObjectArr = [Story]()
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top Stories"
        
        APIRequestManager.manager.getData(endpoint: Story.endpoint){(data:Data?) in
            if data != nil {
                dump(data!)
                if let validStory = Story.generateStory(from: data!) {
                    self.storyObjectArr = validStory
                    dump(self.storyObjectArr)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyObjectArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicStoryCellIdentifier" , for: indexPath) as! BasicStoryCell
        
        let story = storyObjectArr[indexPath.row]
        self.tableView.rowHeight = screenSize.height * 0.28
        
        let attributedString = NSMutableAttributedString(string: story.title, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)])
        let attributedDescription = NSMutableAttributedString(string: "\n\n" + story.byline + "\n" + story.created_date + "\n" + story.abstract, attributes: [NSForegroundColorAttributeName:UIColor.lightGray, NSFontAttributeName:UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)])
        attributedString.append(attributedDescription)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let textLength = attributedString.string.characters.count
        let range = NSRange(location: 0, length: textLength)
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        cell.storyTextView.attributedText = attributedString
        cell.storyTextView.isUserInteractionEnabled = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) Selected" )
        let selectedStory = self.storyObjectArr[indexPath.row]
        guard let validURL = URL(string: selectedStory.url) else {return}
        UIApplication.shared.open(validURL, options: [:], completionHandler: nil)
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 72
    //    }
    
}

