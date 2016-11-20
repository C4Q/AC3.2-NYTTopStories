//
//  Story.swift
//  AC3.2-NYTTopStories
//
//  Created by Tom Seymour on 11/20/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import Foundation

enum NYTParseError: Error {
    case accessingNYT(json: Any)
    case buildingStory(json: Any)
}

class Story {
    let title: String
    let byline: String
    let date: String
    let abstract: String
    let storyUrl: String
    
    init(title: String, byline: String, date: String, abstract: String, storyUrl: String) {
        self.title = title
        self.byline = byline
        self.date = date
        self.abstract = abstract
        self.storyUrl = storyUrl
    }
    
    convenience init?(with dict: [String: Any]) throws {
        guard
            let ti = dict["title"] as? String,
            let by = dict["byline"] as? String,
            let da = dict["published_date"] as? String,
            let ab = dict["abstract"] as? String,
            let st = dict["url"] as? String else { return nil }
        
        let dateArr = da.components(separatedBy: "T")
        let date = dateArr[0]
        self.init(title: ti, byline: by, date: date, abstract: ab, storyUrl: st)
    }
    
    static func buildTopStoryArray(from data: Data) -> [Story]? {
        do {
            let nytJSONData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let wholeNYTDict = nytJSONData as? [String: Any],
                let resultsArray = wholeNYTDict["results"] as? [[String: Any]]
                else { throw NYTParseError.accessingNYT(json: nytJSONData)}
            print(">>>>>>>>>>>>>>>> GOT RESULTS ARRAY")
            var storyArr = [Story]()
            
            for story in resultsArray {
                if let thisStory = try Story(with: story) {
                    storyArr.append(thisStory)
                } else {
                    throw NYTParseError.buildingStory(json: story)
                }
            }
            return storyArr
        }
        catch let NYTParseError.accessingNYT(json: json) {
            print("Error occured while trying to access NYT for object: \(json)")
        }
        catch let NYTParseError.buildingStory(json: json) {
            print("Error occured while trying to creat Story from object: \(json)")
        }
        catch {
            print("Unknown parsing error")
        }
        return nil
    }
}

