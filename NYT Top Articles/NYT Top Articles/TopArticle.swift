//
//  TopArticle.swift
//  NYT Top Articles
//
//  Created by Marcel Chaucer on 11/20/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import Foundation
enum GeneralError: Error {
    case parsingError
}

class TopArticle {
    let title: String
    let byLine: String
    let date: String
    let abstract: String
    let url: URL
    
    init(title: String, byLine: String, date: String, abstract: String, url: URL) {
        self.title = title
        self.byLine = byLine
        self.date = date
        self.abstract = abstract
        self.url = url
        }
    
    convenience init?(withDict dict: [String:Any]) {
        if let title = dict["title"] as? String,
        let byLine = dict["byline"] as? String,
        let date = dict["created_date"] as? String,
        let abstract = dict["abstract"] as? String,
        let stringURL = dict["url"] as? String,
        let url = URL(string: stringURL)
            {
                self.init(title: title, byLine: byLine, date: date, abstract: abstract, url: url)
        }
        else {
            return nil
        }
    }
    static func get(topArticle: Data) -> [TopArticle]? {
        var articlesToReturn: [TopArticle]? = []
        
        do {
            let jsonData = try? JSONSerialization.jsonObject(with: topArticle, options: [])
            guard let response = jsonData as? [String: Any],
                let results = response["results"] as? [[String: Any]] else { throw GeneralError.parsingError }
            
            for articles in results {
                if let article =  TopArticle(withDict: articles) {
                    articlesToReturn?.append(article)
                }
            }
            
        }
        catch GeneralError.parsingError {
            print("Problem parsing")
        }
        catch {
            print("Some other type of error")
        }
    return articlesToReturn
    }
    
}
