//
//  GetUserImageResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/8/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct GetUserImageResponse : Codable {
    var image: Data
    enum CodingKeys: String, CodingKey {
       case image = "data"
}
}
