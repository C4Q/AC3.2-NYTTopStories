//
//  TopStory.swift
//  NYTTopStories
//
//  Created by Erica Y Stevens on 11/20/16.
//  Copyright © 2016 Erica Stevens. All rights reserved.
//

import Foundation

class TopStory {
    var title: String
    var byLine: String
    var datePublished: String
    var abstract: String
    var url: URL
    
    init?(from dict: [String:Any]) {
        guard let title = dict["title"] as? String,
            let byLine = dict["byline"] as? String,
            let date = dict["published_date"] as? String,
            let abstract = dict["abstract"] as? String else {
                print("FAILURE in INIT?")
                return nil
        }
        
        guard let stringURL = dict["url"] as? String,
            let url = URL(string: stringURL) else {
            print("Why won't url parse!!!!")
            return nil
        }
        self.title = title
        self.byLine = byLine
        self.datePublished = date
        self.abstract = abstract
        self.url = url
    }
    
    static func parseObjects(from arr: [[String:Any]]) -> [TopStory] {
        var topStories = [TopStory]()
        
        arr.forEach { (storyDict) in
            guard let story = TopStory(from: storyDict) else {
                print("FAILURE PARSING")
                return
            }
            topStories.append(story)
        }
        return topStories
    }
}
