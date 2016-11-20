//
//  APIRequestManager.swift
//  NYT-TopStories
//
//  Created by Harichandan Singh on 11/20/16.
//  Copyright © 2016 Harichandan Singh. All rights reserved.
//

import Foundation

class APIRequestManager {
    //MARK: - Properties
    static let manager: APIRequestManager = APIRequestManager()
    
    //MARK: - Initializers
    private init() {}
    
    //MARK: - Methods
    func getData(endpoint: String, callback: @escaping (Data?) -> Void) {
        guard let url: URL = URL(string: endpoint) else { return }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session: URLSession = URLSession(configuration: .default)
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered: \(error)")
            }
            
            guard let jsonData = data else { return }
            callback(jsonData)
        }.resume()
    }
}
