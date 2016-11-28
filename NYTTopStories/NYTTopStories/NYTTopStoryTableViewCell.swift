//
//  NYTTopStoryTableViewCell.swift
//  NYTTopStories
//
//  Created by Karen Fuentes on 11/20/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class NYTTopStoryTableViewCell: UITableViewCell {

    @IBOutlet weak var NYTTopStoryAbstract: UITextView!
    @IBOutlet weak var NYTTopStoryByLine: UILabel!
    @IBOutlet weak var NYTTopStoryTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
