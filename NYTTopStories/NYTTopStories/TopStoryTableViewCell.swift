//
//  TopStoryTableViewCell.swift
//  NYTTopStories
//
//  Created by Erica Y Stevens on 11/20/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import UIKit

class TopStoryTableViewCell: UITableViewCell {

    @IBOutlet weak var topStoryByLineLabel: UILabel!
    @IBOutlet weak var topStoryDatePublishedLabel: UILabel!
    @IBOutlet weak var topStoryAbstractLabel: UILabel!
    @IBOutlet weak var topStoryTitleLabel: UILabel!
    
    var titleText = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
