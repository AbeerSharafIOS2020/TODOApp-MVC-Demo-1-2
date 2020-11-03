//
//  UpdateProfileResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct UpdateProfileResponse : Codable {
    let success : Bool
    let user : UserData
    
    enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case user = "data"
    }
}
