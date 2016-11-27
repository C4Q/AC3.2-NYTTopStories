//
//  NYTTopStories.swift
//  AC3.2-NYTTopStories
//
//  Created by Edward Anchundia on 11/20/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

class NYTTopStories: NSObject {
    let title: String
    let byLine: String
    let date: String
    let abstract: String
    let url: String
    let materialTypeFacet: String
    let desFacet: [String]
    let orgFacet: [String]
    let perFacet: [String]
    let geoFacet: [String]
    
    
    init(title: String, byLine: String, date: String, abstract: String, url: String, materialTypeFacet: String, desFacet: [String], orgFacet: [String], perFacet: [String], geoFacet: [String]) {
        self.title = title
        self.byLine = byLine
        self.date = date
        self.abstract = abstract
        self.url = url
        self.materialTypeFacet = materialTypeFacet
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
    }
    
    static func getTopStories(from data: Data) -> [NYTTopStories]? {
        var returnData: [NYTTopStories]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let response: [String: Any] = jsonData as? [String: Any],
                let results: [[String: Any]] = response["results"] as? [[String: Any]] else {
                    return nil
            }
            results.forEach({ dataObject in
                guard let title = dataObject["title"] as? String,
                    let abstract = dataObject["abstract"] as? String,
                    let url = dataObject["url"] as? String,
                    let byLine = dataObject["byline"] as? String,
                    let date = dataObject["updated_date"] as? String,
                    let materialTypeFacet = dataObject["material_type_facet"] as? String,
                    let desFacet = dataObject["des_facet"] as? [String],
                    let orgFacet = dataObject["org_facet"] as? [String],
                    let perFacet = dataObject["per_facet"] as? [String],
                    let geoFacet = dataObject["geo_facet"] as? [String] else {
                        return
                }
                let details = NYTTopStories(title: title, byLine: byLine, date: date, abstract: abstract, url: url, materialTypeFacet: materialTypeFacet, desFacet: desFacet, orgFacet: orgFacet, perFacet: perFacet, geoFacet: geoFacet)
                returnData?.append(details)
            })
            return returnData
        } catch {
            print("Unknown parsing error")
        }
        return nil
    }
}
