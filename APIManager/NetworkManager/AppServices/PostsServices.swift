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
    func fetchAllPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        
        let postsAPIRequest = PostApiRequest() // apirequest for posts.
       
        // Calling api using NetworkClient.
        NetworkClient().callAPI(request: postsAPIRequest) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    completion(.success(posts))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
    }
}
