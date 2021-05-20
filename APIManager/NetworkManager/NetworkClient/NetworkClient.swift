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
    
    func callAPI<ResponseType>(request: ApiRequest<ResponseType>, completion: @escaping (Result<ResponseType, NetworkError>) -> Void) {
        
        // API Calling using URLSession Task
        let urlRequest = urlRequestFrom(apiRequest: request)
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
    
    private func urlRequestFrom<ResponseType>(apiRequest: ApiRequest<ResponseType>) -> URLRequest {
        
        // Creating a from cleint ApiRequest URLRequest
        let urlFinalString: String = apiRequest.baseURLString() + apiRequest.apiPath() + apiRequest.apiVersion() + apiRequest.endpoint()
        guard let url = URL(string: urlFinalString) else {
            fatalError("\n Failed to create URL from urlFinalString.")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.httpMethod().rawValue
        urlRequest.setValue(apiRequest.contentType(), forHTTPHeaderField: "Content-Type")
        if apiRequest.httpMethod() != .get {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: apiRequest.parameters()!, options: [])
        }
        return urlRequest
    }
    
}
