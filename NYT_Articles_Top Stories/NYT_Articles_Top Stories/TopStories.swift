//
//  TopStories.swift
//  NYT_Articles_Top Stories
//
//  Created by John Gabriel Breshears on 11/20/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

class NewsPaperParts {
    let title: String
    let abstract: String
    let byline: String
    let publishedDate: String
    let url: URL
    
    init(title: String, abstract: String, byline: String, publishedDate: String, url: URL) {
        self.title = title
        self.abstract = abstract
        self.byline = byline
        self.publishedDate = publishedDate
        self.url = url
    }
    convenience init?(dictionary: [String : Any]) {
        if let castedTitle = dictionary["title"] as? String,
            let castedAbstract = dictionary["abstract"] as? String,
            let castedByline = dictionary["byline"] as? String,
            let castedPublishedDate = dictionary["published_date"] as? String,
            let stringUrl = dictionary["url"] as? String,
            let castedUrl: URL = URL(string: stringUrl) {
            
            
            self.init(title: castedTitle, abstract: castedAbstract, byline: castedByline, publishedDate: castedPublishedDate, url: castedUrl)
        }else{
            return nil
        }
    }
    
    static func buildNewsPaperPartsArray(from data: Data) -> [NewsPaperParts]? {
        do {
            let NYTJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let theCompleteNewsDictionary = NYTJSONData as? [String : Any] else {return nil}
            guard let resultsArray = theCompleteNewsDictionary["results"] as? [[String : Any]] else {return nil}
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Got Results Array")
            
            var newsPaperPartsArray = [NewsPaperParts]()
            
            for resultsDictionary in resultsArray {
                if let useConvenienceInit = NewsPaperParts(dictionary: resultsDictionary) {
                    newsPaperPartsArray.append(useConvenienceInit)
                }
            }
            return newsPaperPartsArray
        }
        catch let error as NSError {
            print("Error occured while parsing: \(error.localizedDescription)")
        }
        return nil
    }
}

