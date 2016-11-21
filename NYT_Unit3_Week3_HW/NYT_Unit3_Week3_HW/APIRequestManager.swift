//
//  APIRequestManager.swift
//  NYT_Unit3_Week3_HW
//
//  Created by Thinley Dorjee on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

class APIRequestManager{
    static let manager = APIRequestManager()
    private init(){}
    
    func getJsonData(endPoint: String, completion: @escaping ((Data?)->Void)){
        guard let myURL = URL(string: endPoint) else {return}
        let session = URLSession(configuration: .default)
        session.dataTask(with: myURL) { (data, response, error) in
            if error != nil{
                print("Error encountered: \(error)")
            }
            guard let validData = data else {return}
            completion(validData)
        }.resume()
    }
}
