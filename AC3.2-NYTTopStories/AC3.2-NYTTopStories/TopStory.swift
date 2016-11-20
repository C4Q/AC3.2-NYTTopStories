//
//  TopStory.swift
//  AC3.2-NYTTopStories
//
//  Created by Victor Zhong on 11/20/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import Foundation

enum TopStoryModelParseError: Error {
    case results, section, title, abstract, url, byline, date
}

class TopStory {
    let section:    String
    let title:      String
    let abstract:   String
    let url:        String
    let byline:     String
    let date:       String //"created_date"
    
    init(
        section:    String,
        title:      String,
        abstract:   String,
        url:        String,
        byline:     String,
        date:       String) {
        self.section = section
        self.title = title
        self.abstract = abstract
        self.url = url
        self.byline = byline
        self.date = date
    }
    
    convenience init?(from dictionary: [String : AnyObject]) throws {
        guard let section = dictionary["section"] as? String else { throw TopStoryModelParseError.section }
        guard let title = dictionary["title"] as? String else { throw TopStoryModelParseError.title }
        guard let abstract = dictionary["abstract"] as? String else { throw TopStoryModelParseError.abstract }
        guard let url = dictionary["url"] as? String else { throw TopStoryModelParseError.url }
        guard let byline = dictionary["byline"] as? String else { throw TopStoryModelParseError.byline }
        guard let date = dictionary["created_date"] as? String else { throw TopStoryModelParseError.date }
        
        self.init(
            section: section,
            title: title,
            abstract: abstract,
            url: url,
            byline: byline,
            date: date)
    }
    
    static func getStories(from data: Data) -> [TopStory]? {
        var storiesToReturn: [TopStory]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let validData = jsonData as? [String : AnyObject],
                let results = validData["results"] as? [[String : AnyObject]] else {
                    throw TopStoryModelParseError.results
            }
            
            for stories in results {
                if let story = try TopStory(from: stories) {
                    storiesToReturn?.append(story)
                }
            }
        }
        catch {
            print("An \(error) error was found")
        }
        return storiesToReturn
    }
}
/*
 "section": "U.S.",
 "subsection": "Politics",
 "title": "Trump Meets With Romney as He Starts to Look Outside His Inner Circle",
 "abstract": "President-elect Donald J. Trump on Saturday moved to mend fences with rivals, meeting with Mitt Romney to discuss naming him secretary of state.",
 "url": "http://www.nytimes.com/2016/11/20/us/politics/donald-trump-mitt-romney-secretary-state.html",
 "byline": "By MICHAEL S. SCHMIDT and JULIE HIRSCHFELD DAVIS",
 "item_type": "Article",
 "updated_date": "2016-11-19T17:07:17-05:00",
 "created_date": "2016-11-19T12:15:23-05:00",
 "published_date": "2016-11-19T12:15:23-05:00",
 "material_type_facet": "",
 "kicker": "",
 */
