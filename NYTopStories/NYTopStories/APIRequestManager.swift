//
//  APIRequestManager.swift
//  NYTopStories
//
//  Created by Ilmira Estil on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIManager {
    static let manager = APIManager()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping (Data?) -> () ) {
        guard let myURL = URL(string: endPoint) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Encountered error durring session:   \(error)")
            }
            guard let validData = data else { return }
            callback(validData)
            }.resume()
    }
    
}
