//
//  Article.swift
//  NYTopStories
//
//  Created by Ilmira Estil on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation



class Article: NSObject {
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let articleURL: String
    let byline: String
    let itemType: String
    let updatedDate: String
    let createdDate: String
    let publishedDate: String
    
    
    init(section: String, subsection: String, title: String, abstract: String, articleURL: String, byline: String, itemType: String, updatedDate: String, createdDate: String, publishedDate: String)
    {
        self.section = section
        self.subsection = subsection
        self.title = title
        self.abstract = abstract
        self.articleURL = articleURL
        self.byline = byline
        self.itemType = itemType
        self.updatedDate = updatedDate
        self.createdDate = createdDate
        self.publishedDate = publishedDate
        
    }
    
    /*
    convenience init?(withDict: [String : String]) throws {
        if
        let nSection = withDict["section"],
        let nSubsection = withDict["subsection"],
        let nTitle = withDict["title"],
        let nAbstract = withDict["abstract"],
        let nArticleURL = withDict["url"],
        let nByline = withDict["byline"],
        let nItemType = withDict["item_type"],
        let nUpdatedDate = withDict["updated_date"],
        let nCreatedDate = withDict["created_date"],
        let nPublishedDate = withDict["published_date"]
        {
            self.init(section: nSection, subsection: nSubsection, title: nTitle, abstract: nAbstract, articleURL: nArticleURL, byline: nByline, itemType: nItemType, updatedDate: nUpdatedDate, createdDate: nCreatedDate, publishedDate: nPublishedDate)
        }
        else {
            return nil
        }
    }
 */

    static func articles(from data: Data) -> [Article]? {
        var articlesToReturn: [Article] = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response = jsonData as? [String : AnyObject]
                else
            {
                print("response error")
                return nil
            }
            
            guard let results = response["results"] as? [[String:Any]]
                else
            {
                print("results error")
                return nil
            }
            
            for withDict in results {
             guard
                let nSection = withDict["section"] as? String,
                let nSubsection = withDict["subsection"] as? String,
                let nTitle = withDict["title"] as? String,
                let nAbstract = withDict["abstract"] as? String,
                let nArticleURL = withDict["url"] as? String,
                let nByline = withDict["byline"] as? String,
                let nItemType = withDict["item_type"] as? String,
                let nUpdatedDate = withDict["updated_date"] as? String,
                let nCreatedDate = withDict["created_date"] as? String,
                let nPublishedDate = withDict["published_date"] as? String
                else {return nil}
             
                articlesToReturn.append(Article.init(section: nSection, subsection: nSubsection, title: nTitle, abstract: nAbstract, articleURL: nArticleURL, byline: nByline, itemType: nItemType, updatedDate: nUpdatedDate, createdDate: nCreatedDate, publishedDate: nPublishedDate))
            }
            
        } catch let error as NSError {
            print("Error: \(error)")
        }
        
        return articlesToReturn
    }
    
    
}
