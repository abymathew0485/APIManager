//
//  Comment.swift
//  APIManager
//
//  Created by Aby Mathew on 20/05/21.
//

import Foundation

/*
 {
    "postId": 1,
    "id": 1,
    "name": "id labore ex et quam laborum",
    "email": "Eliseo@gardner.biz",
    "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
  }
 
 */
struct Comment: Codable {
    var postId: UInt64?
    var id: UInt64?
    var name: String?
    var email: String?
    var body: String?
}
