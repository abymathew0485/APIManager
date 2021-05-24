//
//  APIRequest.swift
//  APIManager
//
//  Created by Aby Mathew on 19/05/21.
//

import Foundation

// Base protocol for all API requests
protocol APIRequest {
    
    var apiBaseUrl: String              { get }
    var apiType: HTTPMethod             { get }
    var apiPath: String                 { get }
    var apiVersion: String              { get }
    var apiEndpoint: String             { get }
    var apiParams: Parameters           { get }
    var apiHeaders: HTTPHeaders         { get }
    
    func loadData<ResponseType: Codable>(completion: @escaping(Result<ResponseType, NetworkError>) -> Void)
    

}

extension APIRequest {
    
    var apiBaseUrl: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    
    var apiPath: String {
        return ""
    }
    
    var apiType: HTTPMethod {
        return .post
    }
    
    var apiAbsoluteUrl: String {
        return "\(apiBaseUrl)\(apiPath)\(apiVersion)\(apiEndpoint)"
    }
    
    var apiHeaders: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    var apiVersion: String  {
        return ""
    }
    var apiEndpoint: String  {
        return ""
    }
    
    var apiParams: Parameters {
        return nil
    }
    
    func loadData<ResponseType: Codable>(completion: @escaping(Result<ResponseType, NetworkError>) -> Void) {
        NetworkClient().callApi(for: self, completion: completion)
    }
}



