//
//  Stories.swift
//  TopStoriesV2
//
//  Created by Cris on 11/20/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

enum StoriesParseError: Error {
    case recordDict, title, abstract, url, byLine
}

class Stories {
    let storyURlString: String
    let storyTitle: String
    let storyAbstrct: String
    let storyByLine: String
    
    
    //MARK: - Initializers ------------------
    init(storyURlString: String, storyTitle: String, storyAbstrct: String, storyByLine: String) {
        self.storyURlString = storyURlString
        self.storyTitle = storyTitle
        self.storyAbstrct = storyAbstrct
        self.storyByLine = storyByLine
    }
    
    //MARK: - Methods --------------
    static func object(from data: Data) -> [Stories]? {
        
        var stories: [Stories]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let response: [String : Any] = jsonData as? [String : Any],
                let storyDict: [[String : Any]] = response["results"] as? [[String : Any]]
                else { throw StoriesParseError.recordDict }
            
            for storyObject in storyDict {
                guard let title = storyObject["title"] as? String else { throw StoriesParseError.title }
                guard let abstract = storyObject["abstract"] as? String else { throw StoriesParseError.abstract }
                guard let url = storyObject["url"] as? String else { throw StoriesParseError.url }
                guard let byLine = storyObject["byline"] as? String else {throw StoriesParseError.byLine }
                
                let story = Stories(storyURlString: url, storyTitle: title, storyAbstrct: abstract, storyByLine: byLine)
                stories?.append(story)
            }
        }
        catch StoriesParseError.title {
            print("ERROR PARSING TITTLE")
        }
        catch StoriesParseError.abstract {
            print("ERROR PARSING ABSTRACT")
        }
        catch StoriesParseError.url {
            print("ERROR PARSING URL")
        }
        catch StoriesParseError.byLine {
            print("ERROR PARSING BYLINE")
        }
        catch {
            print("UNKNOWN PARSING ERROR")
        }
        return stories
    }
    
}
