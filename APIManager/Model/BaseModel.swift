//
//  BaseModel.swift
//  APIManager
//
//  Created by Aby Mathew on 21/05/21.
//

import Foundation


struct BaseModel<DataTypeName: Codable> : Codable {
    var status: String?
    var data: DataTypeName?
    var message: String?
}
