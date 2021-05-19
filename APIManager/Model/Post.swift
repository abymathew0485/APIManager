//
//  Post.swift
//  APIManager
//
//  Created by Aby Mathew on 19/05/21.
//

import Foundation

/*
 {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  }
*/

struct Post : Codable {
    
    var userID: UInt64?
    var id: UInt64?
    var title: String?
    var body: String?
    
}
