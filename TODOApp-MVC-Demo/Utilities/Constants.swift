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
     static var brearerToken = "Bearer \(UserDefaultsManager.shared().token ?? "")"
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

//colors
struct Colors {
     static let labelColor = UIColor.hexStringToUIColor(hex: "#AA32FD")
     static let primaryColor =
          UIColor.hexStringToUIColor(hex: "#4E0E69")
     static let placholderColor = UIColor.hexStringToUIColor(hex:"#D3C1DA")
     
}
// label text
struct LabelText {
     static let loginLabel = "Log In"
     static let signUpLabel = "Sign Up"
     static let noAccountLabel = "Don’t have an acoount?"
     static let alreadyHaveAccountLabel = "Already have an account?"
     static let noDataFoundLabel = "No Data Found"
     static let editProfileLabel = "Edit Profile"
     static let logOutLabel = "LOG OUT"
}
//Title Message
struct TitleMsg {
     static let invalidName = "Invalid Name"
     static let invalidEmail = "Invalid Email"
     static let invalidPassword = "Invalid Password"
     static let invalidAge = "Invalid Age"
     static let invalid = "Invalid"
     static let profileEditting = "Profile Editting"
     static let edittingSelection = "Editting Selection"
     static let confirm = "Confirm"
     static let imageSelection = "Image Selection"
}
//Title Alert Action
struct AlertActionTitle {
     static let no = "No"
     static let yes = "Yes"
     static let name = "Name"
          static let email = "Email"
     static let password = "Password"
     static let age = "Age"
     static let cancel = "Cancel"
     static let camera = "Camera"
     static let photoAlbum = "Photo Album"
     static let success = "Success"
}
// Messege content
struct Messages {
     static let  emailAndPassErrorMsg = "Please Enter Valid Email and Password"
     static let nameErrorMsg = "Enter Valid name ..at least consists two letters and first & last name"
     static let passwordErrorMsg = "Password Must be at Least 8 Characters"
     static let ageErrorMsg = "Enter valid age .. greater than or equal 10 years"
     static let emailErrorMsg = "Please Enter Valid Email"
     static let invalidErrorMsg = "Please Enter your Valid data"
     static let deleteTaskSuccessMsg = "Delete the task Successfully"
     static let dateErrorMsg = "Enter the date , please .."
     static let taskErrorMsg = "Enter your task details.."
     static let taskSavedSuccessMsg = "Done saved the task successfully"
     static let edittingDoneSuccessMsg = "Editting Done Successfully.."
     static let edittingMsg = "Are you sure , Do you want to edit your profile?"
     static let deleteTaskMsg = "Are you sure you want to Delete the task ?"
     static let editSelection = "please...press what do you whant to edit it?"
     static let enterYourNew = "Enter your new"
     static let confirmLogout = "Are you sure Do you want log out?"
     static let howToPickedImageMsg = "From where you want to pick this image?"
     static let tryAgainWithCorrect =   "please...try again with correct"
     
     }
// Screen title
struct Titles {
     static let loginTitle = "Log In"
     static let signUpTitle = "Sign Up"
     static let saveTitle = "Save"
     static let addTaskTitle = "Add Task"
}

struct PlaceHolders {
     static let emailPlaceHolder = "Email"
     static let passwordPlaceHolder = "Password"
     static let namePlaceHolder = "Name"
     static let agePlaceHolder = "Age"
     static let firstNotePlaceHolder = "First note"
     static let dateAndTimePlaceHolder = "Date And Time"
     static let yourNew = "your new"
}

// NamesObjects
struct ImagesName {
     static let userNameIcon = "userNameIcon"
     static let toDoIcon = "todo"
     static let userEmailcon = "emailIcon"
     static let userAgeIcon = "ageIcon"
     static let profileDateIcon = "todo"
     static let profileUpdateDateIcon = "LOGINImage"
     static let passwordIcon = "passwordIcon"
     static let backgroundImage = "background"
     static let deleteIcon = "deleteIconCopy"
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

