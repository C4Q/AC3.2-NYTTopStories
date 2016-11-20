//
//  TopStoryTableViewCell.swift
//  AC3.2-NYTTopStories
//
//  Created by Tom Seymour on 11/20/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class TopStoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
