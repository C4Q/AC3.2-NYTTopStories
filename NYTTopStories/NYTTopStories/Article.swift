//
//  Article.swift
//  NYTTopStories
//
//  Created by Sabrina Ip on 11/20/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import Foundation

enum ParseError: Error {
    case jsonSerialization
    case results
}

class Article {
    
    static let nytTopStoriesUrl = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=62223032c424466e980a30cca8ce4dd0"
    
    var section: String
    var subsection: String
    var title: String
    var abstract: String
    var urlString: String
    var byline: String
    var updatedDate: String
    var createdDate: String
    var publishedDate: String
    var desFacet: [String]
    var orgFacet: [String]
    var perFacet: [String]
    var geoFacet: [String]
    var shortURLString: String
    
    init(resultsDict: [String: Any]) {
        section = resultsDict["section"] as! String
        subsection = resultsDict["subsection"] as! String
        title = resultsDict["title"] as! String
        abstract = resultsDict["abstract"] as! String
        urlString = resultsDict["url"] as! String
        byline = resultsDict["byline"] as! String
        updatedDate = resultsDict["updated_date"] as! String
        createdDate = resultsDict["created_date"] as! String
        publishedDate = resultsDict["published_date"] as! String
        desFacet = resultsDict["des_facet"] as! [String]
        orgFacet = resultsDict["org_facet"] as! [String]
        perFacet = resultsDict["per_facet"] as! [String]
        geoFacet = resultsDict["geo_facet"] as! [String]
        shortURLString = resultsDict["short_url"] as! String
    }

    static func getJson(from data: Data) -> [Article] {
        var articles = [Article]()
        
        do {
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: [])
            guard let response = jsonData as? [String: Any] else { throw ParseError.jsonSerialization }
            guard let results = response["results"] as? [[String: Any]] else { throw ParseError.results }
            
            for result in results {
                articles.append(Article(resultsDict: result))
            }
        }
        catch ParseError.jsonSerialization {
            print("jsonSerialization error")
        }
        catch ParseError.results {
            print("results error")
        }
        catch {
            print("error")
        }
        
        return articles
    }

}
