//
//  News.swift
//  AC3.2-NYTTopStories
//
//  Created by Kadell on 11/19/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import Foundation

enum NewsParseErrorData: Error {
    case results, title, authors, summary, publishedDate, url
}


class News {
    
    let title: String
    let authors: String
    let summary: String
    let published: String
    let url: String
    
    init(title: String, authors: String, summary: String, published: String, url: String) {
        self.title = title
        self.authors = authors
        self.summary = summary
        self.published = published
        self.url = url
    }
    
    static func newsArticles(from data: Data) -> [News]? {
        var newsToReturn: [News]? = []
        
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
                
                
                let allNews = News(title: title, authors: authors, summary: summary, published: date, url: url )
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
        catch {
            print("Unknown Error")
        }
        
        return newsToReturn
    }
}
