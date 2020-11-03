//
//  GetAllTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct GetAllTaskResponse : Codable {
    let count : Int
    let data : [TaskData]

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case data = "data"
    }
}
