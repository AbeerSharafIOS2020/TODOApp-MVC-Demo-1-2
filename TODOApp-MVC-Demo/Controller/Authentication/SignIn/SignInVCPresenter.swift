//
//  SignInVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol SignInVCDelegate {
    func showErrorMsg(message: String)
    func showSuccessMsg(message: String)
    func processOnStart()
    func processOnStop()
}
class SignInVCPresenter: NSObject {
    var delegate: SignInVCDelegate!
    func validateData(email: String, password: String){
        if isValidEmail(email) && isValidPassword(password){
            self.serviceLogin(with: email, password: password)
        }else {
            self.delegate.showErrorMsg(message: "Please Enter Valid Email and Password")
        }
    }
     // email validation
     func isValidEmail(_ email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            self.delegate.showErrorMsg(message: "Please Enter an Email")
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
              self.delegate.showErrorMsg(message: "Please Enter Valid Email")
            return false
        }
        return true
    }
    // password validation
    func isValidPassword(_ password: String?) -> Bool {
              guard let password = password, !password.isEmpty, password.count >= 8 else {
                  self.delegate.showErrorMsg(message:"Password Must be at Least 8 Characters")
                  return false
              }
              return true
          }
    
//    fileprivate func verify(email: String, password: String){
//        if email == "p.ab_sh@homail.com" && password == "12345678" {
//            self.delegate.userSuccessFullyLoggedIn()
//        }else{
//            self.delegate.showErrorMsg(message:"Please valid email and password ")
//        }
//    }

    }
extension SignInVCPresenter {
private func serviceLogin(with email: String?, password: String?) {
            UserDefaultsManager.shared().token = nil
            UserDefaultsManager.shared().userID = nil
    guard let email = email, self.isValidEmail(email) else {return}
    guard let password = password, self.isValidPassword(password) else {return}
    self.delegate.processOnStart()
    APIManager.login(email: email, password: password) { (response) in
        switch response {
        case .success(let result):
            let result = result
            UserDefaultsManager.shared().isLogin = true
            UserDefaultsManager.shared().token = result.token
            UserDefaultsManager.shared().userID = result.user.id
            UserDefaultsManager.shared().name = "\(result.user.name)"
            AppDelegate.shared().switchToMainState()
        case .failure(let error):
            print(error.localizedDescription)
            self.delegate.showErrorMsg(message: "\(error.localizedDescription)")
            
        }
        self.delegate.processOnStop()
    }
}
}
