//
//  HeadlinesTableViewCell.swift
//  NYTTopStories
//
//  Created by Sabrina Ip on 11/20/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import UIKit

class HeadlinesTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineAndDateLabel: UILabel!
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
