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
            return("Invalid Name","Enter Valid name ..at least consists two letters and first & last name")
        case .email:
            return("Invalid Email", "Please Enter Valid Email")
        case .password:
            return("Invalid Password", "Password Must be at Least 8 Characters")
            
        case .age:
            return("Invalid Age", "Enter valid age .. greater than or equal 10 years")
        case .noData:
            return("Invalid", "Please Enter your data ")
        }
    }
}

enum ErrorEmptyMsg{
    case name, email, password, age
    var errorMsg: (title: String, message: String) {
        switch self {
        case .name:
            return("TextField Empty","Enter Valid name ..at least consists two letters and first & last name")
        case .email:
            return("TextField Empty", "Please Enter Valid Email")
        case .password:
            return("TextField Empty", "Password Must be at Least 8 Characters")
            
        case .age:
            return("TextField Empty", "Enter valid age .. greater than or equal 10 years")
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
            case false : return ErrorEmptyMsg.name.errorMsg
            case true : break
            }
            switch email?.isEmpty ?? false {
            case false : return ErrorValidMsg.email.errorMsg
            case true : break
            }
            switch password?.isEmpty ?? false {
            case false : return ErrorValidMsg.password.errorMsg
            case true : break
            }
            switch age?.isEmpty ?? false {
            case false : return ErrorValidMsg.age.errorMsg
            case true : break
            }
        return nil
        //return ErrorValidMsg.noData.errorMsg
    }
    func getTextValidation(name: String?, email: String?, password: String?, age: String?) -> (String, String)? {
        
        if (notEmptyGetText(name: name, email: email, password: password, age: age) == nil)
            {
//         if let name = name, !name.isEmpty,
//            let email = email?.trimmed, !email.isEmpty,
//            let password = password, !password.isEmpty,
//            let age = age, !age.isEmpty {
            
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


