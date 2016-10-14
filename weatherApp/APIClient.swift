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
    
    // apiKey to use at the end of parameter [appID:{apiKey}]
    open let apiKey = "c0975937bf3851dce8d0114b0e5fcd6e"
    
    // ________________________________________
    // MARK: Initialization
    init(){
        let config = URLSessionConfiguration.default // Session Configuration
        session = URLSession(configuration: config) // Load Session
    }
    
    // ________________________________________
    // MARK: Request
    
    // Creates a request with url
    //
    // - parameter url: The URL to send request.
    // - parameter method: The REST method.
    // - parameter parameters: The parameters for the request.
    //
    // TODO: Create API:URLRequestConvertible
    open func request(
        _ url: URL,
        method:HTTPMethod = .get,
        parameters: Parameters? = nil,
        successHandler: (([String:Any]) -> Void)? = nil,
        failHandler: ((HTTPURLResponse) -> Void)? = nil) {
        
        // Generate urlRequest
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = method.rawValue
        guard let parameters = parameters else {return}
        
        // Encode parameters into urlRequest
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded;charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        if var urlComponents = URLComponents(url:url,
                                             resolvingAgainstBaseURL: false) {
            let percentEncodedQuery = (urlComponents.percentEncodedQuery.map{ $0 + "&" } ?? "") + query(parameters)
            urlComponents.percentEncodedQuery = percentEncodedQuery
            urlRequest.url = urlComponents.url
            self.log("[REQUEST]: \(urlRequest.url?.absoluteString)")
        }
        
        // Request Task
        let task = session.dataTask(with: urlRequest, completionHandler: {
        (data, response, error) in
        
        if error != nil {
            print(error!.localizedDescription)
        } else {
            
            do {
                guard let httpResponse:HTTPURLResponse = response as? HTTPURLResponse else {return}
                
                // Success
                if httpResponse.statusCode == 0 || httpResponse.statusCode == 200 {
                    if let json = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String:Any]
                    {
                        if let successHandler = successHandler {
                            successHandler(json)
                        }
                    }
                } else {
                    // Fail
                    if let failHandler = failHandler {
                        failHandler(httpResponse)
                    }
                }
                
                
            } catch {
                
                print("error in JSONSerialization")
                
            }
            
            
        }
        
    })
    task.resume()
    }
    
    public func query(_ parameters: [String: Any]) -> String {
        var components: [String] = []
        
        for (key, value) in parameters {
            components.append("\(key)=\(value)")
        }
        
        return components.joined(separator: "&")
    }
    
    // Print string
    fileprivate func log(_ string: String?) {
        guard let string = string else {return}
        print(string)
    }
}
