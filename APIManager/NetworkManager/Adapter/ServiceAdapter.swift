//
//  ServiceAdapter.swift
//  ShoppingCart
//
//  Created by Visakh S R on 21/05/21.
//

import Foundation


/// An adapter is introduced in between the service layer and the view in order to avoid the dependency
/// between the high level and low level components
struct ServiceAdapter: APIService {
    
    // Adapter must satisfies the Service protocol.
    // Based on the requirement the developer can introduce individual adapter for
    // each API calls
    
    let request: APIRequest
   
    func makeApiCall<ResponseType: Codable>(completion: @escaping (Result<ResponseType, NetworkError>) -> Void) {
        request.loadData(completion: completion)
    }
    
}




/// The fallback adapter which handles the API failure cases
/// Set any service protocol instance to the fallback property
struct ServiceFallbackAdapter: APIService{
    
    let request: APIRequest
    let fallback: APIService

    func makeApiCall<ResponseType>(completion: @escaping (Result<ResponseType, NetworkError>) -> Void) where ResponseType : Decodable, ResponseType : Encodable {
        
        request.loadData(completion: {(result: Result<ResponseType, NetworkError>) in
            switch result {
            case .success:
                completion(result)
            case .failure:
                fallback.makeApiCall(completion: completion)
            }
        })

    }
    
}




