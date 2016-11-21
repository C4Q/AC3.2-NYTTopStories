//
//  timesTableViewCell.swift
//  NYT_Unit3_Week3_HW
//
//  Created by Thinley Dorjee on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class timesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
