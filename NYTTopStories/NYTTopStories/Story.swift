//
//  Story.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/19/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

enum StoryModelParseError: Error {
    case dictionary
    case results
    case section
    case subsection
    case title
    case abstract
    case url
    case byline
    case item_type
    case updated_date
    case created_date
    case published_date
    case material_type_facet
    case kicker
    case multimedia
    case short_url
    case des_facet
    case org_facet
    case per_facet
    case geo_facet
}

class Story: NSObject {
    static let endpoint = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=4939e631466f482a868559ed9565d78e"
    
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let item_type: String
    let updated_date: String
    let created_date: String
    let published_date: String
    let material_type_facet: String
    let kicker: String
    let des_facet: [String]
    let org_facet: [String]
    let per_facet: [String]
    let geo_facet: [String]
    let multimedia: [Media]
    let short_url: String
    
    init(section: String,
         subsection: String,
         title: String,
         abstract: String,
         url: String,
         byline: String,
         item_type: String,
         updated_date: String,
         created_date: String,
         published_date: String,
         material_type_facet: String,
         kicker: String,
         des_facet: [String],
         org_facet: [String],
         per_facet: [String],
         geo_facet: [String],
         multimedia: [Media],
         short_url: String){
        self.section = section
        self.subsection = subsection
        self.title = title
        self.abstract = abstract
        self.url = url
        self.byline = byline
        self.item_type = item_type
        self.updated_date = updated_date
        self.created_date = created_date
        self.published_date = published_date
        self.material_type_facet = material_type_facet
        self.kicker = kicker
        self.des_facet = des_facet
        self.org_facet = org_facet
        self.per_facet = per_facet
        self.geo_facet = geo_facet
        self.multimedia = multimedia
        self.short_url = short_url
    }
    
    convenience init(section: String,
                     subsection: String,
                     title: String,
                     abstract: String,
                     url: String,
                     byline: String,
                     item_type: String,
                     updated_date: String,
                     created_date: String,
                     published_date: String,
                     material_type_facet: String,
                     kicker: String,
                     short_url: String) {
        self.init(section: section,
                  subsection: subsection,
                  title: title,
                  abstract: abstract,
                  url: url,
                  byline: byline,
                  item_type: item_type,
                  updated_date: updated_date,
                  created_date: created_date,
                  published_date: published_date,
                  material_type_facet: material_type_facet,
                  kicker: kicker,
                  des_facet: [],
                  org_facet: [],
                  per_facet: [],
                  geo_facet: [],
                  multimedia: [],
                  short_url: short_url)
    }
    
    convenience init? (from dictionary: [String: AnyObject]) throws{
        guard let section = dictionary["section"] as? String else {
            throw StoryModelParseError.section
        }
        guard let subsection = dictionary["subsection"] as? String else {
            throw StoryModelParseError.subsection
        }
        guard let title = dictionary["title"] as? String else {
            throw StoryModelParseError.title
        }
        guard let abstract = dictionary["abstract"] as? String else {
            throw StoryModelParseError.abstract
        }
        guard let url = dictionary["url"] as? String else {
            throw StoryModelParseError.url
        }
        guard let byline = dictionary["byline"] as? String else {
            throw StoryModelParseError.byline
        }
        guard let item_type = dictionary["item_type"] as? String else {
            throw StoryModelParseError.item_type
        }
        guard let updated_date = dictionary["updated_date"] as? String else {
            throw StoryModelParseError.updated_date
        }
        guard let created_date = dictionary["created_date"] as? String else {
            throw StoryModelParseError.created_date
        }
        guard let published_date = dictionary["published_date"] as? String else {
            throw StoryModelParseError.published_date
        }
        guard let material_type_facet = dictionary["material_type_facet"] as? String else {
            throw StoryModelParseError.material_type_facet
        }
        guard let kicker = dictionary["kicker"] as? String else {
            throw StoryModelParseError.kicker
        }
        guard let multimedia = dictionary["multimedia"] as? [[String:AnyObject]] else {
            throw StoryModelParseError.multimedia
        }
        guard let des_facet = dictionary["des_facet"] as? [String] else {
            throw StoryModelParseError.des_facet
        }
        guard let org_facet = dictionary["org_facet"] as? [String] else {
            throw StoryModelParseError.org_facet
        }
        guard let per_facet = dictionary["per_facet"] as? [String] else {
            throw StoryModelParseError.per_facet
        }
        guard let geo_facet = dictionary["geo_facet"] as? [String] else {
            throw StoryModelParseError.geo_facet
        }
        var multimediaArr = [Media]()
        for media in multimedia {
            if let m = Media(from: media) {
                multimediaArr.append(m)
            } else {
                throw StoryModelParseError.multimedia
            }
        }
        guard let short_url = dictionary["short_url"] as? String else {
            throw StoryModelParseError.short_url
        }
        self.init(section: section,
                  subsection: subsection,
                  title: title,
                  abstract: abstract,
                  url: url,
                  byline: byline,
                  item_type: item_type,
                  updated_date: updated_date,
                  created_date: created_date,
                  published_date: published_date,
                  material_type_facet: material_type_facet,
                  kicker: kicker,
                  des_facet: des_facet,
                  org_facet: org_facet,
                  per_facet: per_facet,
                  geo_facet: geo_facet,
                  multimedia: multimediaArr,
                  short_url: short_url)
    }
    
    static func generateStory(from data: Data) -> [Story]? {
        dump(data)
        var storyToReturn = [Story]()
        do{
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dictionary = jsonData as? [String: AnyObject] else {
                throw StoryModelParseError.dictionary
            }
            
            guard let results = dictionary["results"] as? [[String: AnyObject]] else {
                throw StoryModelParseError.results
            }
            
            try results.forEach({ (result) in
                if let story = try Story(from: result) {
                    storyToReturn.append(story)
                }
            })
        }
        catch {
            print(error)
        }
        return storyToReturn
    }
}


/*{
 "section": "U.S.",
 "subsection": "Politics",
 "title": "Trump Meets With Romney as He Starts to Look Outside His Inner Circle",
 "abstract": "President-elect Donald J. Trump on Saturday moved to mend fences with rivals, meeting with Mitt Romney to discuss naming him secretary of state.",
 "url": "http://www.nytimes.com/2016/11/20/us/politics/donald-trump-mitt-romney-secretary-state.html",
 "byline": "By MICHAEL S. SCHMIDT and JULIE HIRSCHFELD DAVIS",
 "item_type": "Article",
 "updated_date": "2016-11-19T17:07:17-05:00",
 "created_date": "2016-11-19T12:15:23-05:00",
 "published_date": "2016-11-19T12:15:23-05:00",
 "material_type_facet": "",
 "kicker": "",
 "des_facet": [
 "United States Politics and Government"
 ],
 "org_facet": [
 "Trump National Golf Club"
 ],
 "per_facet": [
 "Trump, Donald J",
 "Romney, Mitt"
 ],
 "geo_facet": [],
 "multimedia": [
 {
 "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-thumbStandard.jpg",
 "format": "Standard Thumbnail",
 "height": 75,
 "width": 75,
 "type": "image",
 "subtype": "photo",
 "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
 "copyright": "Hilary Swift for The New York Times"
 },
 {
 "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-thumbLarge.jpg",
 "format": "thumbLarge",
 "height": 150,
 "width": 150,
 "type": "image",
 "subtype": "photo",
 "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
 "copyright": "Hilary Swift for The New York Times"
 },
 {
 "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-articleInline.jpg",
 "format": "Normal",
 "height": 133,
 "width": 190,
 "type": "image",
 "subtype": "photo",
 "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
 "copyright": "Hilary Swift for The New York Times"
 },
 {
 "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-mediumThreeByTwo210.jpg",
 "format": "mediumThreeByTwo210",
 "height": 140,
 "width": 210,
 "type": "image",
 "subtype": "photo",
 "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
 "copyright": "Hilary Swift for The New York Times"
 },
 {
 "url": "https://static01.nyt.com/images/2016/11/20/us/20TRANSITION-SUB/20TRANSITION-SUB-superJumbo.jpg",
 "format": "superJumbo",
 "height": 1432,
 "width": 2048,
 "type": "image",
 "subtype": "photo",
 "caption": "Donald J. Trump and Mitt Romney parted after their meeting at Trump National Golf Club in Bedminster, N.J., on Saturday.",
 "copyright": "Hilary Swift for The New York Times"
 }
 ],
 "short_url": "http://nyti.ms/2faYgzB"
 },
 */
