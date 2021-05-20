//
//  ApiRequestProtocol.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

typealias Parameters = [String : Any]
typealias HTTPHeaders = [String : String]

protocol ApiRequestProtocol {
    
    var baseURL: String {get}
    var httpMethod: HTTPMethod {get}
    var apiPath: String {get}
    var apiVersion: String {get}
    var endpoint: String {get}
    var parameters: [String : Any] {get}
    var httpHeaders: [String : String] {get}
}

// API request defualt implementations using protocol extensions
extension ApiRequestProtocol {
    var baseURL: String {
       return "https://jsonplaceholder.typicode.com/"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    var apiPath: String {
        return ""
    }
    var apiVersion: String {
        return ""
    }
    var endpoint: String {
        return ""
    }
    var parameters: Parameters {
        return [:]
    }
    var httpHeaders: HTTPHeaders {
        ["Content-Type" : "application/json"]
    }
}


/// ApiClientProtocol - for NetworkClient
/// It will act as an interface between network layer and application
protocol ApiClientProtocol {
    
    func callApi<ResponseType>(request: ApiRequestProtocol, completion: @escaping (Result<ResponseType, NetworkError>) -> Void) where ResponseType : Codable
}
