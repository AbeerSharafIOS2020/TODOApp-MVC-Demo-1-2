//
//  UserData.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct UserData: Codable {
    
    var id: String
    var name, email: String
    var age: Int
    let createdAt : String
    let updatedAt : String
    
    enum CodingKeys: String, CodingKey {
        case age, name, email
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case id = "_id"
    }
}
