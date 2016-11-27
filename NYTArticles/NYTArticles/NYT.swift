//
//  NYT.swift
//  NYTArticles
//
//  Created by Annie Tung on 11/20/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

enum parsingErrors: Error {
    case json, results, title, byline, summary, publishedDate, url, section, subsection, des_facet, org_facet, per_facet, geo_facet
}

class NYT: NSObject {
    let title: String
    let byline: String
    let summary: String
    let publishedDate: String
    let url: String
    let section: String
    let subsection: String
    let des_facet: [String]
    let org_facet: [String]
    let per_facet: [String]
    let geo_facet: [String]
    
    init(title: String, byline: String, summary: String, publishedDate: String, url: String, section: String, subsection: String, des_facet: [String], org_facet: [String], per_facet: [String], geo_facet: [String]) {
        self.title = title
        self.byline = byline
        self.summary = summary
        self.publishedDate = publishedDate
        self.url = url
        self.section = section
        self.subsection = subsection
        self.des_facet = des_facet
        self.org_facet = org_facet
        self.per_facet = per_facet
        self.geo_facet = geo_facet
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
                guard let section = result["section"] as? String else { throw parsingErrors.section }
                guard let subsection = result["subsection"] as? String else { throw parsingErrors.subsection }
                guard let des_facet = result["des_facet"] as? [String] else { throw parsingErrors.des_facet }
                guard let org_facet = result["org_facet"] as? [String] else { throw parsingErrors.org_facet }
                guard let per_facet = result["per_facet"] as? [String] else { throw parsingErrors.per_facet }
                guard let geo_facet = result["geo_facet"] as? [String] else { throw parsingErrors.geo_facet }
                
                let nytObject = NYT(title: title, byline: byline, summary: summary, publishedDate: publishedDate, url: url, section: section, subsection: subsection, des_facet: des_facet, org_facet: org_facet, per_facet: per_facet, geo_facet: geo_facet)
                nytToReturn.append(nytObject)
                dump(nytToReturn)
            })
        } catch {
            print("Error parsing: \(error)")
        }
        return nytToReturn
    }
}
