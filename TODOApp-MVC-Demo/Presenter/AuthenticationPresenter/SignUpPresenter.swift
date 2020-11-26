//
//  SignUpPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.

import Foundation
//MARK:- Protocol of SignInPresenter
protocol SignUpPresenterProtocol: class {
    associatedtype View
    func onViewDidLoad(view : View)
    func trySignUp(name: String?, email: String?, password: String?, age: String?)
}
//MARK:- SignUpPresenter
class SignUpPresenter: SignUpPresenterProtocol {
    
    //MARK:- Properties
    typealias View = MainViewProtocol
    private weak var view : MainViewProtocol?
    //MARK:- Private Methods
    private func validateField(name: String?, email: String?, password: String?, age:String?) -> Bool{
        if let notValidation = Validator.shared().getTextValidation(name: name, email: email, password: password, age: age) {
            view?.confirmationAlert1(title: notValidation.0, message: notValidation.1)
            return false
        }
        return true
    }
//        if !validator.isValidName(name){
//            return false
//        }
//        if !validator.isValidEmail(email){
//            return false
//        }
//        if !validator.isValidPassword(password){
//            return false
//        }
//        if !validator.isValidAge(age){
//            return false
//        }
//        return true
//    }
}
//MARK:- extension
extension SignUpPresenter {
    //MARK:-  Handle Response
    private func serviceRegisterData(with name: String?, email: String?, password: String?, age: Int?) {
        UserDefaultsManager.shared().imagName = nil
        UserDefaultsManager.shared().userID = nil
        self.view?.processOnStart()
        APIManager.register(name: name!, email: email!, password: password!, age: age! ) {
            (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showErrorMsg(message: error.localizedDescription)
                self.view?.processOnStop()
            case .success(let result):
                UserDefaultsManager.shared().isLogin = false
                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().userID = result.user.id
                UserDefaultsManager.shared().name = result.user.name
                Validator.shared().createImageByName()
                AppDelegate.shared().switchToAuthState()
            }
            self.view?.processOnStop()
        }
    }
    //MARK:- The confirm of the SignInVCPresenterDelegate Protocol
    internal func onViewDidLoad(view : MainViewProtocol){
        self.view = view
    }
    func trySignUp(name: String?, email: String?, password: String?, age: String?){
        if validateField(name: name, email: email, password: password, age: age){
            self.serviceRegisterData(with: name, email: email!, password: password!, age: Int(age!))
        }else {
            self.view?.showErrorMsg(message: "Please Enter Valid Email and Password")
        }
    }
}
