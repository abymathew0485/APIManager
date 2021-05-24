//
//  Comments.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation

//https://jsonplaceholder.typicode.com/comments
class CommentsApiRequest : APIRequest {

    var apiEndpoint: String {
        return "comments"
    }
    
    var apiType: HTTPMethod {
        return .get
    }
    
}
