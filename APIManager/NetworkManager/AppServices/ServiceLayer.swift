//
//  ServiceLayer.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation

class ServiceLayer {
    
    private var apiClient: ApiClientProtocol? // making depedency to ApiClientProtocol for implementing Dependancy Inversion.
    
    init(apiClient: ApiClientProtocol){
        self.apiClient = apiClient
    }
}

extension ServiceLayer {
   
    /// All Posts Fetching
    /// - Parameter completion: completion description
    func fetchAllPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        
        let postsAPIRequest = PostApiRequest() // apirequest for posts.
       
        // Calling api using NetworkClient.
        self.apiClient?.callApi(request: postsAPIRequest, completion: completion)
    }
    
    /// All Comments Fetching
    func fetchAllComments(completion: @escaping (Result<[Comment], NetworkError>) -> Void){
        
        // comment API request
        let commentAPIRequest = CommentsApiRequest()
        self.apiClient?.callApi(request: commentAPIRequest, completion: completion)
    }
    
}
