//
//  StoryTableViewCell.swift
//  NYTTopStories
//
//  Created by Eashir Arafat on 11/20/16.
//  Copyright © 2016 Evan. All rights reserved.
//
import UIKit

class StoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storyAuthor: UILabel!
    @IBOutlet weak var storyDate: UILabel!
    @IBOutlet weak var storySummary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
