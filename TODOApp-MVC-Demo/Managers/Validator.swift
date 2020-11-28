//
//  Validator.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

enum ErrorValidMsg{
    case name, email, password, age, noData
    var errorMsg: (title: String, message: String) {
        switch self {
        case .name:
            return(TitleMsg.invalidName,Messages.nameErrorMsg)
        case .email:
            return(TitleMsg.invalidEmail, Messages.emailErrorMsg)
        case .password:
            return(TitleMsg.invalidPassword, Messages.passwordErrorMsg)
        case .age:
            return(TitleMsg.invalidAge, Messages.ageErrorMsg)
        case .noData:
            return(TitleMsg.invalid, Messages.invalidErrorMsg)
        }
    }
}

enum ErrorEmptyMsg{
    case name, email, password, age
    var errorMsg: (title: String, message: String) {
        switch self {
        case .name:
            return(TitleMsg.invalidName,Messages.nameErrorMsg)
        case .email:
            return(TitleMsg.invalidEmail, Messages.emailErrorMsg)
        case .password:
            return(TitleMsg.invalidPassword, Messages.passwordErrorMsg)
        case .age:
            return(TitleMsg.invalidAge, Messages.ageErrorMsg)
        }
    }
}
class Validator {
    //MARK:- SingleTon
    private static let sharedIntance = Validator()
    class func shared()->Validator {
        return Validator.sharedIntance
    }
    //MARK:- Private Methods
    func notEmptyGetText(name: String?, email: String?, password: String?, age: String?) -> (String, String)?{
            switch name?.isEmpty ?? false {
            case true : return ErrorEmptyMsg.name.errorMsg
            case false : break
            }
            switch email?.isEmpty ?? false {
            case true : return ErrorValidMsg.email.errorMsg
            case false : break
            }
            switch password?.isEmpty ?? false {
            case true : return ErrorValidMsg.password.errorMsg
            case false : break
            }
            switch age?.isEmpty ?? false {
            case  true: return ErrorValidMsg.age.errorMsg
            case  false: break
            }
        return nil
        //return ErrorValidMsg.noData.errorMsg
    }
    func getTextValidation(name: String?, email: String?, password: String?, age: String?) -> (String, String)? {
        
        if (notEmptyGetText(name: name, email: email, password: password, age: age) == nil)
            {
            switch isValidName(name) {
            case false : return ErrorValidMsg.name.errorMsg
            case true : break
            }
            switch isValidEmail(email) {
            case false : return ErrorValidMsg.email.errorMsg
            case true : break
            }
            switch isValidPassword(password) {
            case false : return ErrorValidMsg.password.errorMsg
            case true : break
            }
            switch isValidAge(Int(age!)) {
            case false : return ErrorValidMsg.age.errorMsg
            case true : break
            }
            return nil
        }
        return ErrorValidMsg.noData.errorMsg
    }
}
//MARK:- extension
extension Validator {
    // name validation
    func isValidName(_ name: String?) -> Bool {
        let nameTemp = name?.split(separator: " ")
        guard let name =  name?.trimmed, !name.isEmpty, nameTemp?.count ?? 0 >= 2, name.count  >= 2  else {
            return false
        }
        return true
    }
    
    // email validation
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            return false
        }
        return true
    }
    // password validation
    func isValidPassword(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            return false
        }
        return true
    }
    //age validation
    func isValidAge(_ age: Int?) -> Bool {
        guard let age = age, String(age) != "" , age != 0 , age >= 10 else {
            return false
        }
        return true
    }
    
    //create image by user name
    func createImageByName() {
        let name = "\(UserDefaultsManager.shared().name ?? "" )"
        var firstName = ""
        var lastName = ""
        print("name: \(name)")
        let nameBuffer = name.split(separator: " ")
        print("nameBuffer : \(nameBuffer)")
        if nameBuffer.count >= 2 {
            firstName = String(nameBuffer[0])
            lastName = String(nameBuffer[1])
        } else {
            firstName = String(nameBuffer[0])
        }
        let imageByName = "\(firstName.first?.uppercased() ?? "" )\(lastName.first?.uppercased() ?? "")"
        print("image: \(imageByName) )")
        UserDefaultsManager.shared().imagName = "\(imageByName)"
    }
    
}


