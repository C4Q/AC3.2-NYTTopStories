//
//  NYT.swift
//  NYTArticles
//
//  Created by Annie Tung on 11/20/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

enum parsingErrors: Error {
    case json, results, title, byline, summary, publishedDate, url
}

class NYT {
    let title: String
    let byline: String
    let summary: String
    let publishedDate: String
    let url: String
    
    init(title: String, byline: String, summary: String, publishedDate: String, url: String) {
        self.title = title
        self.byline = byline
        self.summary = summary
        self.publishedDate = publishedDate
        self.url = url
    }
    
    static func parseData(from data: Data) -> [NYT]? {
        
        var nytToReturn = [NYT]()
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDataCasted = jsonData as? [String:Any] else { throw parsingErrors.json }
            
            guard let results = jsonDataCasted["results"] as? [[String:Any]] else { throw parsingErrors.results }
            
            try results.forEach({ result in
                guard let title = result["title"] as? String else { throw parsingErrors.title }
                guard let byline = result["byline"] as? String else { throw parsingErrors.byline }
                guard let summary = result["abstract"] as? String else { throw parsingErrors.summary }
                guard let publishedDate = result["published_date"] as? String else { throw parsingErrors.publishedDate }
                guard let url = result["url"] as? String else { throw parsingErrors.url }
                
                let nytObject = NYT(title: title, byline: byline, summary: summary, publishedDate: publishedDate, url: url)
                nytToReturn.append(nytObject)
                dump(nytToReturn)
            })
        } catch {
            print("Error parsing: \(error)")
        }
        return nytToReturn
    }
}
