//
//  PostAPIRequest.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation


//https://jsonplaceholder.typicode.com/posts

/// POSTS API REQUEST
class PostApiRequest: ApiRequestProtocol {
    
    var endpoint: String {
        return "posts"
    }
    
}
