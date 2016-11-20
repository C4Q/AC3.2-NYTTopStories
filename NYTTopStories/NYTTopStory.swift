//
//  NYTTopStory.swift
//  NYTTopStories
//
//  Created by Karen Fuentes on 11/19/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import Foundation

enum NewsModelParseError: Error {
    case results,title,abstract,byLine,url
}
class NYTTopStories {
    let title: String
    let abstract: String
    let byLine: String
    let url: String
    
    init (title:String, abstract: String, byline: String, url:String) {
        self.title = title
        self.abstract = abstract
        self.byLine = byline
        self.url = url
    }
    convenience init?(from dict: [String:Any]) throws {
        guard let title = dict["title"] as? String else {
            throw NewsModelParseError.title
        }
        guard let abstract = dict["abstract"] as? String else {
            throw NewsModelParseError.abstract
        }
        guard let byLine = dict["byline"] as? String else {
            throw NewsModelParseError.byLine
        }
        guard let url = dict["url"] as? String else {
            throw NewsModelParseError.url
        }
        self.init (
            title: title,
            abstract: abstract,
            byline: byLine,
            url: url
        )
    }
    static func getNews(from data: Data) -> [NYTTopStories]? {
        var topStoriesToReturn: [NYTTopStories]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
                let items: [[String : AnyObject]] = response["results"] as? [[String : AnyObject]]
                else {
                    throw NewsModelParseError.results
            }
            
            for topStoryDict in items {
                if let article = try NYTTopStories(from: topStoryDict){
                    topStoriesToReturn?.append(article)
                    print("We have data!")
                }
            }
        }
        catch NewsModelParseError.results{
            print("Error encountered with parsing results)")
        }
        catch {
            print("Unknown parsing error: \(error)")
        }
        
        return topStoriesToReturn
    }
}
