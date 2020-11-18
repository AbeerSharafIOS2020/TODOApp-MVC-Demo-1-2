//
//  SignInVCPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol of SignInVCPresenter
protocol SignInVCPresenterDelegate: class {
    associatedtype View
    func onViewDidLoad(view : View)
    func validateData(email: String, password: String)
}
//MARK:- SignInVCPresenter
class SignInVCPresenter: SignInVCPresenterDelegate {
    //MARK:- Properties
    typealias View = SignInVCDelegate
    private var loginView : SignInVCDelegate?
    private var valaidator : Vali
    //MARK:- Private Methods
    // email validation
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            self.loginView?.showErrorMsg(message: "Please Enter an Email")
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            self.loginView?.showErrorMsg(message: "Please Enter Valid Email")
            return false
        }
        return true
    }
    // password validation
    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            self.loginView?.showErrorMsg(message:"Password Must be at Least 8 Characters")
            return false
        }
        return true
    }    
}
//MARK:-  Handle Response
extension SignInVCPresenter {
    private func serviceLogin(with email: String?, password: String?) {
        UserDefaultsManager.shared().token = nil
        UserDefaultsManager.shared().userID = nil
        guard let email = email, self.isValidEmail(email) else {return}
        guard let password = password, self.isValidPassword(password) else {return}
        self.loginView?.processOnStart()
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
                self.loginView?.showErrorMsg(message: "\(error.localizedDescription)")
                
            }
            self.loginView?.processOnStop()
        }
    }
}
//MARK:- extension that confirm the SignInVCPresenterDelegate Protocol
extension SignInVCPresenter {
    internal func onViewDidLoad(view : SignInVCDelegate){
        self.loginView = view
    }
    
    internal func validateData(email: String, password: String){
        if  isValidEmail(email) && isValidPassword(password){
            self.serviceLogin(with: email, password: password)
        }else {
            self.loginView?.showErrorMsg(message: "Please Enter Valid Email and Password")
        }
    }
}
