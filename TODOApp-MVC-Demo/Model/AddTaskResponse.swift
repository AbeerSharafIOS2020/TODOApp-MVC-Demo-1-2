//
//  AddTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct AddTaskResponse : Codable {
    
    let success : Bool
    let data : TaskData

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case data = "data"
    }   
}
