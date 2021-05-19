//
//  PostAPIRequest.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation


//https://jsonplaceholder.typicode.com/posts

/// POSTS API REQUEST
class PostApiRequest: ApiRequest<[Post]> {
    
    override func endpoint() -> String {
        return "posts"
    }
    
}
