//
//  FavoriteCell.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.


import UIKit

class FavoriteCell: UITableViewCell {

    static let identifier = "FavoriteCellIdentifier"
    
    var favoriteSelected: Story!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
