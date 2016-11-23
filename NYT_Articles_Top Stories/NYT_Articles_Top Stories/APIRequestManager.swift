//
//  APIRequestManager.swift
//  NYT_Articles_Top Stories
//
//  Created by John Gabriel Breshears on 11/20/16.
//  Copyright © 2016 John Gabriel Breshears. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
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
