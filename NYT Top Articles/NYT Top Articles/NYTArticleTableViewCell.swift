//
//  NYTArticleTableViewCell.swift
//  NYT Top Articles
//
//  Created by Marcel Chaucer on 11/19/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class NYTArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
