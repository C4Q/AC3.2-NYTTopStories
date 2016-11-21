//
//  StoryCell.swift
//  TopStoriesV2
//
//  Created by Cris on 11/20/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {
    static let identifier = "StoryCellID"
    
    let storyTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont.boldSystemFont(ofSize: 20.0)
        title.sizeToFit()
        title.backgroundColor = .blue
        return title
    }()
    
    let storyByLine: UILabel = {
        let by = UILabel()
        by.translatesAutoresizingMaskIntoConstraints = false
        by.numberOfLines = 0
        by.lineBreakMode = .byWordWrapping
        by.backgroundColor = .green
        return by
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    func setupCell() {
        
        addSubview(storyTitle)
//        addSubview(storyByLine)
        storyTitle.frame = CGRect(x: 10, y: 20, width: frame.width + 75, height: frame.height + 25)
    
        
        storyByLine.frame = CGRect(x: 10, y: storyTitle.frame.height + 25, width: self.frame.width + 75, height: self.frame.height)
//        storyByLine.topAnchor.constraint(equalTo: storyTitle.bottomAnchor).isActive = true
        
    }
}
