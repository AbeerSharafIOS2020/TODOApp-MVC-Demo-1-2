//
//  Constants.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

// Storyboards
struct Storyboards {
    static let authentication = "Authentication"
    static let main = "Main"
    
}
// Cells
struct Cells {
    static let taskDataTVCell = "TaskDataTVCell"
}
// View Controllers
struct ViewControllers {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let todoListVC = "TodoListVC"
    static let addTaskVC = "ADDTaskVC"
    static let profileTVC = "ProfileTVC"
}

// Urls
struct URLs {
    static let base = "https://api-nodejs-todolist.herokuapp.com"
    static let user = "/user"
    static let login = base + user + "/login"
    static let register = base + user + "/register"
    static let logout = base + user + "/logout"
    static let addTask = base + "/task"
    static let getAllTask = addTask
    static let getUserProfile = base + user + "/me"
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
}

// Parameters Keys
struct ParameterKeys {
    static let email = "email"
    static let password = "password"
    static let name = "name"
    static let age = "age"
    static let description = "description"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
    static let imagName = "ImageName"
}

//struct LoadingProgress {
//    static let  loading : NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 70, height: 70), type: .ballRotateChase, color: UIColor.blue , padding: 2)
//
//}
