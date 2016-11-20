//
//  Story.swift
//  NYT-TopStories
//
//  Created by Harichandan Singh on 11/20/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

class Story {
    //MARK: - Properties
    let title: String
    let byline: String
    let date: String
    let abstract: String
    let urlString: String
    
    //MARK: - Initializers
    init(title: String, byline: String, date: String, abstract: String, urlString: String) {
        self.title = title
        self.byline = byline
        self.date = date
        self.abstract = abstract
        self.urlString = urlString
    }
    
    //MARK: - Methods
    static func turnDataIntoStoriesArray(data: Data) -> [Story]? {
        do {
            if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                guard let resultsArray = jsonData["results"] as? [[String: Any]] else {
                    print("Error while casting JSON data.")
                    return nil
                }
                
                var allStories: [Story] = []
                
                for element in resultsArray {
                    guard let title = element["title"] as? String else {
                        print("Error finding title key.")
                        continue
                    }
                    guard let byline = element["byline"] as? String else {
                        print("Error finding byline key.")
                        continue
                    }
                    guard let date = element["published_date"] as? String else {
                        print("Error finding the date key.")
                        continue
                    }
                    guard let abstract = element["abstract"] as? String else {
                        print("Error finding the abstract key.")
                        continue
                    }
                    guard let urlString = element["url"] as? String else {
                        print("Error finding the url key.")
                        continue
                    }
                    let story: Story = Story(title: title, byline: byline, date: date, abstract: abstract, urlString: urlString)
                    allStories.append(story)
                }
                return allStories
            }
            
        }
        catch {
            print("Error encountered when parsing data: \(data)")
        }
        return nil
    }
    
}
