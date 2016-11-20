//
//  APIRequestManager.swift
//  NYTArticles
//
//  Created by Annie Tung on 11/20/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import Foundation

class APIRequestManager {
    
    static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping ((Data?) -> Void)) {
        
        guard let url = URL(string: endPoint) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("Error encountered: \(error)")
            }
            
            if data != nil {
                print(data!)
                callback(data)
            }
            }.resume()
    }
}
