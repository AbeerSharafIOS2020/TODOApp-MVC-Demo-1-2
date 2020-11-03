//
//  LogOutResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct LogOutResponse : Codable {
    let success : Bool

    enum CodingKeys: String, CodingKey {

        case success = "success"
    }
}
