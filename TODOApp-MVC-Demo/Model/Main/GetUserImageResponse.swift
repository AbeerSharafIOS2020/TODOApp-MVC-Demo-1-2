//
//  GetUserImageResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/8/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

struct GetUserImageResponse : Codable {
    let image: Data
    enum CodingKeys: String, CodingKey {
        case image = "image"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(Data.self, forKey: .image)!
    }
}
