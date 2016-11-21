//
//  APIRequestManager.swift
//  AC3.2-NYTTopStories
//
//  Created by Madushani Lekam Wasam Liyanage on 11/19/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callBack: @escaping (Data?) -> Void) {
        
        guard let myURL = URL(string: endPoint) else {return}
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL){(data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error durring session: \(error)")
            }
            
            guard let validData = data else {return}
            
            callBack(validData)
            
            }.resume()
    }
}
