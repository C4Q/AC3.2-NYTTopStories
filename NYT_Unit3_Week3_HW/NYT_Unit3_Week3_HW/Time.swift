//
//  Time.swift
//  NYT_Unit3_Week3_HW
//
//  Created by Thinley Dorjee on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

struct Time{
    let title: String
    let byline: String
    let updated_date: String
    let abstract: String
    let url: String
    
    /*
     title: "Donald Trump, Obama, Thanksgiving: Your Weekend Briefing",
     byline: "By KAREN WORKMAN and MERRILL D. OLIVER",
     updated_date: "2016-11-20T06:00:41-05:00",
     abstract: "Here’s what you need to know about the week’s top stories.",
     url: "http://www.nytimes.com/2016/11/20/briefing/donald-trump-obama-thanksgiving.html",
     */
    
    static func getTimeData(from data: Data) -> [Time]?{
        do{
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            guard let response = jsonData as? [String: Any] else {return nil}
            guard let results = response["results"] as? [[String: Any]] else {return nil}
            
            var dataToReturn = [Time]()
            
            for element in results{
                guard let articleTitle = element["title"] as? String else {return nil}
                guard let articleByline = element["byline"] as? String else {return nil}
                guard let articleUpdated = element["updated_date"] as? String else {return nil}
                guard let articleAbstract = element["abstract"] as? String else {return nil}
                guard let articleUrl = element["url"] as? String else {return nil}
                
                let allData = Time(title: articleTitle, byline: articleByline, updated_date: articleUpdated, abstract: articleAbstract, url: articleUrl)
                dataToReturn.append(allData)
            }
            return dataToReturn
        }
        catch let error as NSError{
            print("Error encountered: \(error)")
        }
        return nil
    }
}
