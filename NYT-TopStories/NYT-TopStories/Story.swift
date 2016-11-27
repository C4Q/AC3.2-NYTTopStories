//
//  Story.swift
//  NYT-TopStories
//
//  Created by Harichandan Singh on 11/20/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

class Story: NSObject {
    //MARK: - Properties
    let title: String
    let byline: String
    let date: String
    let abstract: String
    let des_facet: [String]
    let org_facet: [String]
    let per_facet: [String]
    let geo_facet: [String]
    let urlString: String
    let section: String
    
    //MARK: - Initializers
    init(title: String, byline: String, date: String, abstract: String, des_facet: [String], org_facet: [String], per_facet: [String], geo_facet: [String], urlString: String, section: String) {
        self.title = title
        self.byline = byline
        self.date = date
        self.abstract = abstract
        self.des_facet = des_facet
        self.org_facet = org_facet
        self.per_facet = per_facet
        self.geo_facet = geo_facet
        self.urlString = urlString
        self.section = section
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
                    guard let des_facet = element["des_facet"] as? [String] else {
                        continue
                    }
                    guard let org_facet = element["org_facet"] as? [String] else {
                        continue
                    }
                    guard let per_facet = element["per_facet"] as? [String] else {
                        continue
                    }
                    guard let geo_facet = element["geo_facet"] as? [String] else {
                        continue
                    }
                    guard let urlString = element["url"] as? String else {
                        print("Error finding the url key.")
                        continue
                    }
                    guard let section = element["section"] as? String else {
                        print("Error finding section key")
                        continue
                    }
                    let story: Story = Story(title: title, byline: byline, date: date, abstract: abstract, des_facet: des_facet, org_facet: org_facet, per_facet: per_facet, geo_facet: geo_facet, urlString: urlString, section: section)
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
