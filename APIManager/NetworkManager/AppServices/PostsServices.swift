//
//  PostsServices.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation


class PostsServices {
    
    /// All Posts Fetching
    /// - Parameter completion: completion description
    func fetchAllPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        
        let postsAPIRequest = PostApiRequest() // apirequest for posts.
       
        // Calling api using NetworkClient.
        NetworkClient().callAPI(request: postsAPIRequest, completion: completion)
    }
}
