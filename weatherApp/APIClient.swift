//
//  APIClient.swift
//  weatherApp
//
//  Created by StephenJang on 10/13/16.
//  Copyright © 2016 stephen. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

open class APIClient {
    static let sharedInstance = APIClient()
    open let session: URLSession
    
    init(){
        let config = URLSessionConfiguration.default // Session Configuration
        session = URLSession(configuration: config) // Load Session
    }
    
    open func request(_ url: URL, method:HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders){
    let task = session.dataTask(with: url, completionHandler: {
        (data, response, error) in
        
        if error != nil {
            print(error!.localizedDescription)
        } else {
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                {
                    print(json)
                }
                
            } catch {
                
                print("error in JSONSerialization")
                
            }
            
            
        }
        
    })
    task.resume()
    }
}
