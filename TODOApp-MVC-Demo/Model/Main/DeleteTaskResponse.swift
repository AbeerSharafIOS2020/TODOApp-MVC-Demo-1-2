//
//  DeleteTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct DeleteTaskByIdResponse : Codable {
let success : Bool
let data : DeleteTask?

enum CodingKeys: String, CodingKey {

    case success = "success"
    case data = "data"
}
}
