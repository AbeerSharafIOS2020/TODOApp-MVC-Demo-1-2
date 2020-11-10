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
struct UI {
    static let controller = UIViewController()
    static let mainViewController = MainViewController()
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
    static let login = user + "/login"
    static let register = user + "/register"
    static let logout = user + "/logout"
    static let task = "/task"
    static let getAllTask = task
    static let getUserProfile = user + "/me"
    static let uploadImage = base + getUserProfile + "/avatar"
    static let taskID = "/\(UserDefaultsManager.shared().taskID ?? "")"
    static let deleteTask = task + taskID
    static let uploadImg = getUserProfile + "/avatar"
    static let imageID = "/\(UserDefaultsManager.shared().userID ?? "")"
    static let getImg =  user + imageID + "/avatar"
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
}

// Header Values
struct HeaderValues {
    static let applicationJson = "application/json"
    static let brearerToken = "Bearer \(UserDefaultsManager.shared().token ?? "")"
}

// Parameters Keys
struct ParameterKeys {
    static let email = "email"
    static let password = "password"
    static let name = "name"
    static let age = "age"
    static let description = "description"
    static var edit = "edit"
    static let image = "image"
    static let id = "id"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
    static let imagName = "ImageName"
    static let isLogin = "isLogin"
    static let taskID = "id"
    static let userID = "id"
    static let isUploadImage = "isUploadImage"
    static let name = "name"
}

