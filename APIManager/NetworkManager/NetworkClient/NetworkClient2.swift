//
//  NetworkClient2.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation



extension URLRequest {
    
    static func urlRequestFrom(apiRequest: ApiRequestProtocol) -> URLRequest {
        // Creating a from cleint ApiRequest URLRequest
        let urlFinalString: String = apiRequest.baseURL + apiRequest.apiPath + apiRequest.apiVersion + apiRequest.endpoint
        guard let url = URL(string: urlFinalString) else {
            fatalError("\n Failed to create URL from urlFinalString.")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = apiRequest.httpHeaders
        if apiRequest.httpMethod != .get {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: apiRequest.parameters, options: [])
        }
        return urlRequest
    }
    
}


class NetworkClientNewVersion : ApiClientProtocol {
   
    func callApi<ResponseType>(request: ApiRequestProtocol, completion: @escaping (Result<ResponseType, NetworkError>) -> Void) where ResponseType : Codable {
        
        // URLRequest creating from our custom Request
        let urlRequest = URLRequest.urlRequestFrom(apiRequest: request)
        
        // API Calling using URLSession Task
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            
            #warning("Should Remove this parsing logic to different Data parsing class")
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
    
}
