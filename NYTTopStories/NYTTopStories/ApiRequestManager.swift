//
//  ApiRequestManager.swift
//  NYTTopStories
//
//  Created by Sabrina Ip on 11/20/16.
//  Copyright © 2016 Sabrina. All rights reserved.
//

import Foundation

class ApiRequestManager {
    static let manager = ApiRequestManager()
    private init () {}
    
    func getData(from endpoint: String, complete: @escaping (Data?) -> Void) {
        guard let url = URL(string: endpoint) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {   
                print(error)
            }
            guard let validData = data else { return }
            complete(validData)
        }.resume()
    }
}
