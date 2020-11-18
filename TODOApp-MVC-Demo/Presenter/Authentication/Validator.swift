//
//  Validator.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

protocol ValidatorProtocol: class {
        func isValidName(_ name: String?) -> Bool
        func isValidEmail(_ email: String?) -> Bool
        func isValidPassword(_ password: String?) -> Bool
        func isValidAge(_ age: Int?) -> Bool
    }
class Validator: ValidatorProtocol {
    weak var view: SignInVC!
    init(view: SignInVC) {
        self.view = view
    }
    weak var presenter: SignInVCPresenter!
    init(presenter: SignInVCPresenter) {
        self.presenter = presenter
    }
}
    //MARK:- Extension
extension Validator {
    // name validation
    func isValidName(_ name: String?) -> Bool {
        let nameTemp = name?.split(separator: " ")
        guard let name =  name?.trimmed, !name.isEmpty, nameTemp?.count ?? 0 >= 2, name.count  >= 2  else {
            self.view.showErrorMsg(message:"Enter Valid name ..at least consists two letters and first & last name")
               return false
           }
               return true
       }
    // email validation
     func isValidEmail(_ email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            self.view.showErrorMsg(message: "Please Enter an Email")
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            self.view.showErrorMsg(message: "Please Enter Valid Email")
            return false
        }
        return true
    }
    // password validation
     func isValidPassword(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            self.view.showErrorMsg(message:"Password Must be at Least 8 Characters")
            return false
        }
        return true
    }
     //age validation
   func isValidAge(_ age: Int?) -> Bool {
     guard let age = age, String(age) != "" , age != 0 , age >= 10 else {
          self.view.showErrorMsg(message: "Enter valid age .. greater than or equal 10 years")
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
