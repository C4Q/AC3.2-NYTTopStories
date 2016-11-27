//
//  TopStoriesTableViewCell.swift
//  NYT-TopStories
//
//  Created by Harichandan Singh on 11/20/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import UIKit

class TopStoriesTableViewCell: UITableViewCell {
    //MARK: - Properties
    let cellIdentifier: String = "NYTCell"
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var abstractTextView: UITextView!
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
