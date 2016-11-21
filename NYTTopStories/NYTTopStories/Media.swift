//
//  Multimedia.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

enum MediaModelParseError: Error {
    case url
    case format
    case height
    case width
    case type
    case subtype
    case caption
    case copyright
}

class Media {
    let url: String
    let format: String
    let height: Int
    let width: Int
    let type: String
    let subtype: String
    let caption: String
    let copyright: String

    init(url: String,
        format: String,
        height: Int,
        width: Int,
        type: String,
        subtype: String,
        caption: String,
        copyright: String){
        self.url = url
        self.format = format
        self.height = height
        self.width = width
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
    }
    
    init? (from dictionary: [String: AnyObject]) {
        if let url = dictionary["url"] as? String,
            let format = dictionary["format"] as? String,
            let height = dictionary["height"] as? Int,
            let width = dictionary["width"] as? Int,
            let type = dictionary["type"] as? String,
            let subtype = dictionary["subtype"] as? String,
            let caption = dictionary["caption"] as? String,
            let copyright = dictionary["copyright"] as? String{
            self.url = url
            self.format = format
            self.height = height
            self.width = width
            self.type = type
            self.subtype = subtype
            self.caption = caption
            self.copyright = copyright
        }
        else {
            return nil
        }
    }
}
/*
[
    {
        "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-thumbStandard.jpg",
        "format": "Standard Thumbnail",
        "height": 75,
        "width": 75,
        "type": "image",
        "subtype": "photo",
        "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
        "copyright": "Hilary Swift for The New York Times"
    },
    {
        "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-thumbLarge.jpg",
        "format": "thumbLarge",
        "height": 150,
        "width": 150,
        "type": "image",
        "subtype": "photo",
        "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
        "copyright": "Hilary Swift for The New York Times"
    },
    {
        "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-articleInline.jpg",
        "format": "Normal",
        "height": 133,
        "width": 190,
        "type": "image",
        "subtype": "photo",
        "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
        "copyright": "Hilary Swift for The New York Times"
    },
    {
        "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-mediumThreeByTwo210.jpg",
        "format": "mediumThreeByTwo210",
        "height": 140,
        "width": 210,
        "type": "image",
        "subtype": "photo",
        "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
        "copyright": "Hilary Swift for The New York Times"
    },
    {
        "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-superJumbo.jpg",
        "format": "superJumbo",
        "height": 1432,
        "width": 2048,
        "type": "image",
        "subtype": "photo",
        "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
        "copyright": "Hilary Swift for The New York Times"
    }
],
*/
