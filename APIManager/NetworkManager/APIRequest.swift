//
//  APIRequest.swift
//  APIManager
//
//  Created by Aby Mathew on 19/05/21.
//

import Foundation

//https://jsonplaceholder.typicode.com/posts

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}


/// ApiRequest is the Base Class for all API Requests
class ApiRequest<ResponseType: Codable> {
    
    // 1 HTTPMethod
    func httpMethod() -> HTTPMethod {
        return .get
    }
    // 2. Base url
    func baseURL() -> URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/") else {
            fatalError("faled to get base url in APIRequest")
            }
        return url
    }
    
    // API Path
    
    func apiPath() -> String {
        return ""
    }
    
    // API Version
    func apiVersion() -> String {
        return ""
    }
    
    //  Endpoint
    func endpoint() -> String {
        return ""
    }
    
    //  Parameters
    
    func parameters() -> [String: Any] {
       return [:]
    }
    
    //  ContentType
    func contentType() -> String {
        return "application/json"
    }
    
}
