//
//  NYTTopStories.swift
//  AC3.2-NYTTopStories
//
//  Created by Edward Anchundia on 11/20/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

class NYTTopStories {
    let title: String
    let byLine: String
    let date: String
    let abstract: String
    let url: String
    
    init(title: String, byLine: String, date: String, abstract: String, url: String) {
        self.title = title
        self.byLine = byLine
        self.date = date
        self.abstract = abstract
        self.url = url
    }
    
    static func getTopStories(from data: Data) -> [NYTTopStories]? {
        var returnData: [NYTTopStories]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let response: [String: Any] = jsonData as? [String: Any],
                let results: [[String: Any]] = response["results"] as? [[String: Any]] else {
                    return nil
            }
            results.forEach({ dataObject in
                guard let title = dataObject["title"] as? String,
                    let abstract = dataObject["abstract"] as? String,
                    let url = dataObject["url"] as? String,
                    let byLine = dataObject["byline"] as? String,
                    let date = dataObject["updated_date"] as? String else {
                        return
                }
                let details = NYTTopStories(title: title, byLine: byLine, date: date, abstract: abstract, url: url)
                returnData?.append(details)
            })
            return returnData
        } catch {
            print("Unknown parsing error")
        }
        return nil
    }
}
