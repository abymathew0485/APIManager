//
//  NetworkClient.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation

enum NetworkError: Error {
    case networkError
    case jsonDecodingError
    case unknownError
}


final class NetworkClient {
    
    func callApi<ResponseType: Codable>(for request: APIRequest, completion: @escaping(Result<ResponseType, NetworkError>) -> ()) {
        
        // API Calling using URLSession Task
        let urlRequest = makeRequest(for: request)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            #warning("It's better to move this parsing logic to different Data parsing class")
            guard error == nil else {
                completion(.failure(.networkError))
                return
            }
            if let data = data, let urlResponse = urlResponse as? HTTPURLResponse {
                switch urlResponse.statusCode {
                    case 200 ... 300:
                        print("Success")
                    
                        // Decode Response into Model
                        do {
                            let decodedModel = try JSONDecoder().decode(ResponseType.self, from: data)
                            completion(.success(decodedModel))
                        } catch {
                            completion(.failure(.jsonDecodingError))
                        }
                    
                    default:
                        completion(.failure(.unknownError))
                }
            }
            
        }
        task.resume()
        
    }
    
    /// Creating URLRequest
    /// - Parameter request: from an ApiRequest
    /// - Returns: a request suffice to maka an api call
    private func makeRequest(for request: APIRequest) -> URLRequest {
        guard let url = URL(string: request.apiAbsoluteUrl) else {
            fatalError("\n Failed to create URL.")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod          = request.apiType.rawValue
        urlRequest.allHTTPHeaderFields = request.apiHeaders
        if let params = request.apiParams {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject:params, options: [])
        }
        return urlRequest
    }
    
}
