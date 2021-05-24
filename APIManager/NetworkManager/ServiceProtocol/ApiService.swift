//
//  ApiService.swift
//  ShoppingCart
//
//  Created by Visakh S R on 22/05/21.
//

import Foundation


/// Service protocol  handles for all network calls
protocol APIService {
    

    var request: APIRequest { get }
    
    func makeApiCall<ResponseType: Codable>(completion: @escaping(Result<ResponseType, NetworkError>) -> Void)
}

extension APIService {
    
    
    /// The retry mechanism integrated inside servicefallback adapter
    /// method invokes the retry mechanism
    /// - Parameter fallback: is the protocol which executes when the
    /// retry mechanism is compramised
    /// - Returns: service protocol instance
    func fallback(_ fallback: APIService) -> APIService{
        ServiceFallbackAdapter(request: request, fallback: self)
    }

    
    /// For retrying the service call in case of failure
    /// - Parameter retryCount: is the number of retry attempts
    /// - Returns: the service protocol instance to retry
    func retry(_ retryCount: UInt = 1) -> APIService {
        retryCount == 0 ? self : fallback(self).retry(retryCount - 1)
    }
    
}
