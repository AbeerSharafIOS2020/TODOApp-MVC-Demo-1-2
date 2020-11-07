//
//  String+Validation.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/7/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit


extension String  {
  // name validation
  func isValidName(_ name: String?) -> Bool {
      guard let name =  name?.trimmed, !name.isEmpty, name.count  >= 2  else {
        UI.controller.presentError( with: "Enter Valid name ..at least consists two letters")
             return false
         }
             return true
     }
  
  // password validation
func isValidPassword(_ password: String?) -> Bool {
          guard let password = password, !password.isEmpty, password.count >= 8 else {
              UI.controller.presentError(with: "Password Must be at Least 8 Characters")
              return false
          }
          return true
      }
  func validation(_ email: String?, _ password: String? ) -> Bool{
      guard self.isValidEmail(email) else {return false}
      guard self.isValidPassword(password) else {return false}
      return true
  }

  //age validation
func isValidAge(_ age: Int?) -> Bool {
  guard let age = age, String(age) != "" , age != 0 , age >= 10 else {
      UI.controller.presentError(with: "Enter valid age .. greater than or equal 10 years")
          return false
                }
                    return true
                }
  // MARK:- Private Methods
   func isValidEmail(_ email: String?) -> Bool {
      guard let email = email?.trimmed, !email.isEmpty else {
       UI.controller.presentError(with: "Please Enter an Email")
          return false
      }
      let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
      let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
      if !pred.evaluate(with: email) {
          UI.controller.presentError(with: "Please Enter Valid Email")
          return false
      }
      return true
  }
}
