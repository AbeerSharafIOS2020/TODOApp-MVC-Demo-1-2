//
//  String+trimming.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/4/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
