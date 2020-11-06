//
//  TaskData.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct TaskData : Codable {
    
    let description : String
    let createdAt : String
    let id : String
    
    enum CodingKeys: String, CodingKey {
          case description = "description"
          case createdAt = "createdAt"
          case id = "_id"
       }
}
