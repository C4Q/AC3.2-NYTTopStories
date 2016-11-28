//
//  APIRequestManager.swift
//  SpotifySearch
//
//  Created by Jason Gresh on 10/31/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
//    func getData(endPoint: String, callback: @escaping (Data?) -> Void) {
//        guard let myURL = URL(string: endPoint) else { return }
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        
//        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
//            if error != nil {
//                print("Error durring session: \(error)")
//            }
//            guard let validData = data else { return }
//            
//            callback(validData)
//            }.resume()
//    }
    
    
    func getData(section: String, callback: @escaping (Data?) -> Void) {
        let endPoint: String = "https://api.nytimes.com/svc/topstories/v2/\(section).json?api-key=f41c1b23419a4f55b613d0a243ed3243"
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
            guard let validData = data else { return }
            
            callback(validData)
            }.resume()
    }
    
    
    
    
    
}
