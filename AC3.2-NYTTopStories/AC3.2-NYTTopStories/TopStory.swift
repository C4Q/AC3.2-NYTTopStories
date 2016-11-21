//
//  TopStories.swift
//  AC3.2-NYTTopStories
//
//  Created by Madushani Lekam Wasam Liyanage on 11/19/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

/*
 {
 "results": [
 {
 "section": "string",
 "subsection": "string",
 "title": "string",
 "abstract": "string",
 "url": "string",
 "thumbnail_standard": "string",
 "short_url": "string",
 "byline": "string",
 "item_type": "string",
 "updated_date": "string",
 "created_date": "string",
 "published_date": "string",
 "material_type_facet": "string",
 "kicker": "string",
 "des_facet": [
 "string"
 ],
 "org_facet": [
 "string"
 ],
 "per_facet": [
 "string"
 ],
 "geo_facet": [
 "string"
 ],
 "multimedia": [
 {
 "url": "string",
 "format": "string",
 "height": 0,
 "width": 0,
 "type": "string",
 "subtype": "string",
 "caption": "string",
 "copyright": "string"
 }
 ],
 "related_urls": [
 {
 "suggested_link_text": "string",
 "url": "string"
 }
 ]
 }
 ]
 }
 */

enum TopStoriesModelParseError: Error {
    case results(json: Any)
}

class TopStory {
    
    let title: String
    let byline: String
    let date: String
    let abstract: String
    let url: String
    
    init(title: String, byline: String, date: String, abstract: String, url: String) {
        
        self.title = title
        self.byline = byline
        self.date = date
        self.abstract = abstract
        self.url = url
        
    }
    
    convenience init?(from dictionary: [String : AnyObject]) throws {
        
        if let title = dictionary["title"] as? String,
            let byline = dictionary["byline"] as? String,
            let date = dictionary["published_date"] as? String,
            let abstract = dictionary["abstract"] as? String,
            let url = dictionary["url"] as? String {
            
            self.init(title: title, byline: byline, date: date, abstract: abstract, url: url)
        }
            
        else {
            return nil
        }
        
    }
    
    static func getTopStories(from data: Data) -> [TopStory]? {
        var topStoriesToReturn: [TopStory]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String:AnyObject] = jsonData as? [String:AnyObject],
                let topStoriesArray: [[String : AnyObject]] = response["results"] as? [[String:AnyObject]]
                
                else {
                    throw TopStoriesModelParseError.results(json: jsonData)
            }
            
            for topStoryDict in topStoriesArray {
                if let story = try TopStory(from: topStoryDict) {
                    topStoriesToReturn?.append(story)
                }
            }
            
        }
            
        catch let TopStoriesModelParseError.results(json: json)  {
            print("Error encountered with parsing 'results' key for object: \(json)")
        }
            
        catch {
            print("Unknown parsing error")
        }
        
        return topStoriesToReturn
    }
    
}
