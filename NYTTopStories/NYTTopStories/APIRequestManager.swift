//
//  APIRequestManager.swift
//  NYTTopStories
//
//  Created by Eashir Arafat on 11/20/16.
//  Copyright © 2016 Evan. All rights reserved.
//


import Foundation

class APIRequestManager {
    //the two lines below show that its a singleton
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callback: @escaping (Data?) -> Void) {
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
    
    func downloadImage(urlString: String, callback: @escaping (Data) -> () ) {
        
        guard let imageURL = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: imageURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error:\(error)")
            }
            guard let imageData = data else { return }
            callback(imageData)
            }.resume()
    }
}
