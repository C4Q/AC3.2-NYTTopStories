//
//  TopStoryTableViewCell.swift
//  AC3.2-NYTTopStories
//
//  Created by Madushani Lekam Wasam Liyanage on 11/19/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class TopStoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
