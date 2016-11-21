//
//  APIRequestManager.swift
//  TopStoriesV2
//
//  Created by Cris on 11/20/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

class APIRequestManager {
    static let manager: APIRequestManager = APIRequestManager()
    private init() {}
    
    func getData(APIURlSring: String, completion: @escaping (Data?) -> Void) {
        guard let url: URL = URL(string: APIURlSring) else { return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("ERROR DURING SESSION \(error)")
            }
            if let validData = data {
                completion(validData)
            }
            }.resume()
    }
}
