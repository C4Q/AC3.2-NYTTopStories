//
//  Story.swift
//  NYTTopStories
//
//  Created by Eashir Arafat on 11/20/16.
//  Copyright © 2016 Evan. All rights reserved.
//

import Foundation

enum StoryParseError: Error {
    case response, title, summary, shortUrl, author, date
}

class Story {
    let title: String
    let summary: String
    let shortUrl: String
    let author: String
    let date: String
    
    init(title: String, summary: String, shortUrl: String, author: String, date: String) {
        self.title = title
        self.summary = summary
        self.shortUrl = shortUrl
        self.author = author
        self.date = date
    }
    
    static func getStories(from data: Data) -> [Story]? {
        var stories: [Story]? = []
        
        do {
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response = jsonData as? [String: Any]
                else { throw StoryParseError.response }
            
            guard let results = response["results"] as? [[String: Any]]
                else { throw StoryParseError.title }
            
            for story in results {
                
                guard let title = story["title"] as? String
                    else { throw StoryParseError.title }
                
                guard let summary = story["abstract"] as? String
                    else { throw StoryParseError.summary }
                
                guard let shortUrl = story["short_url"] as? String
                    else { throw StoryParseError.shortUrl }
                
                guard let author = story["byline"] as? String
                    else { throw StoryParseError.author }
                
                guard let date = story["published_date"] as? String
                    else { throw StoryParseError.date }
                
                let validStory = Story(title: title, summary: summary, shortUrl: shortUrl, author: author, date: date)
                
                stories?.append(validStory)
            }
            
            return stories
            
        }
            
        catch {
            print("Error \(error)")
        }
        
        return nil
    }
}
