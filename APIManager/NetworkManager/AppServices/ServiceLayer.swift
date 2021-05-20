//
//  ServiceLayer.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation

class ServiceLayer {
    
    func fetchAllComments(completion: @escaping (Result<[Comment], NetworkError>) -> Void){
        
        // comment API request
        let commentAPIRequest = CommentsApiRequest()
        NetworkClientNewVersion().callApi(request: commentAPIRequest, completion: completion)
    }
}
