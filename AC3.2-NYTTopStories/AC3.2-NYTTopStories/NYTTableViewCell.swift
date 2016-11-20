//
//  NYTTableViewCell.swift
//  AC3.2-NYTTopStories
//
//  Created by Victor Zhong on 11/20/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class NYTTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
