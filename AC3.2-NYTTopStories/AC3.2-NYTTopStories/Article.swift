//
//  News.swift
//  AC3.2-NYTTopStories
//
//  Created by Kadell on 11/19/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import Foundation

enum NewsParseErrorData: Error {
    case results, title, authors, summary, publishedDate, url, facets
}


class Article: NSObject {
    
    let title: String
    let authors: String
    let summary: String
    let published: String
    let url: String
    let des_facet: [String]
    let org_facet: [String]
    let per_facet: [String]
    let geo_facet: [String]
    
    init(title: String, authors: String, summary: String, published: String, url: String, des_facet: [String], org_facet: [String], per_facet: [String], geo_facet: [String] ) {
        self.title = title
        self.authors = authors
        self.summary = summary
        self.published = published
        self.url = url
        self.des_facet = des_facet
        self.org_facet = org_facet
        self.per_facet = per_facet
        self.geo_facet = geo_facet
    }
    
    static func newsArticles(from data: Data) -> [Article]? {
        var newsToReturn: [Article]? = []
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dict = json as? [String: Any],
            let results = dict["results"] as? [[String: Any]]
                    else { throw NewsParseErrorData.results }
            
            for newsDict in results {
                guard let title = newsDict["title"] as? String else { throw NewsParseErrorData.title}
                guard let authors = newsDict["byline"] as? String else { throw NewsParseErrorData.authors }
                guard let summary = newsDict["abstract"] as? String else {throw NewsParseErrorData.summary}
                guard let date = newsDict["published_date"] as? String else {throw NewsParseErrorData.publishedDate}
                guard let url = newsDict["url"] as? String else {throw NewsParseErrorData.url }
                guard let des = newsDict["des_facet"] as? [String] else {throw NewsParseErrorData.facets}
                guard let org = newsDict["org_facet"] as? [String] else {throw NewsParseErrorData.facets}
                guard let per = newsDict["per_facet"] as? [String] else {throw NewsParseErrorData.facets}
                guard let geo = newsDict["geo_facet"] as? [String] else {throw NewsParseErrorData.facets}
                
                let allNews = Article(title: title, authors: authors, summary: summary, published: date, url: url, des_facet: des, org_facet: org, per_facet: per, geo_facet: geo )
                newsToReturn?.append(allNews)
            }
        }
        catch NewsParseErrorData.title {
            print("Error parsing the title")
        }
        catch NewsParseErrorData.results {
            print("Error parsing the results block")
        }
        catch NewsParseErrorData.authors {
            print("Error parsing the Authors")
        }
        catch NewsParseErrorData.summary {
            print("Error parsing the Summary/ Abstract")
        }
        catch NewsParseErrorData.publishedDate {
            print("Error parsing the Date")
        }
        catch NewsParseErrorData.url {
            print("Error parsing the URL")
        }
        catch NewsParseErrorData.facets {
            print("Error parsing one of the Facets")
        }
        catch {
            print("Unknown Error")
        }
        
        return newsToReturn
    }
}
