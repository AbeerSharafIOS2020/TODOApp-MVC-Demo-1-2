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
    func trySignUp(name: String?, email: String?, password: String?, age: Int?)
}
//MARK:- SignUpPresenter
class SignUpPresenter: SignUpPresenterProtocol {
    
    //MARK:- Properties
    typealias View = MainViewProtocol
    private weak var signUpView : MainViewProtocol?
    weak var validator : Validator!
    init(validator: Validator) {
        self.validator = validator
    }
    //MARK:- Private Methods
    private func validateField(name: String?, email: String?, password: String?, age:Int?) -> Bool{
        if !validator.isValidName(name){
            return false
        }
        if !validator.isValidEmail(email){
            return false
        }
        if !validator.isValidPassword(password){
            return false
        }
        if !validator.isValidAge(age){
            return false
        }
        return true
    }
    
    private func userDefaultsData( isLogin: Bool, token: String, userID: String, name: String ){
        UserDefaultsManager.shared().isLogin = isLogin
        UserDefaultsManager.shared().token = token
        UserDefaultsManager.shared().userID = userID
        UserDefaultsManager.shared().name = name
    }
}
//MARK:- extension
extension SignUpPresenter {
    //MARK:-  Handle Response
    private func serviceRegisterData(with name: String?, email: String?, password: String?, age: Int?) {
        UserDefaultsManager.shared().imagName = nil
        UserDefaultsManager.shared().userID = nil
        self.signUpView?.processOnStart()
        APIManager.register(name: name!, email: email!, password: password!, age: age! ) {
            (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.signUpView?.showErrorMsg(message: error.localizedDescription)
                self.signUpView?.processOnStop()
            case .success(let result):
                self.userDefaultsData(isLogin: false, token: result.token,userID: result.user.id, name: result.user.name )
                self.validator.createImageByName()
                AppDelegate.shared().switchToAuthState()
            }
            self.signUpView?.processOnStop()
        }
    }
    //MARK:- The confirm of the SignInVCPresenterDelegate Protocol
    internal func onViewDidLoad(view : MainViewProtocol){
        self.signUpView = view
    }
    func trySignUp(name: String?, email: String?, password: String?, age: Int?){
        if validateField(name: name, email: email, password: password, age: age){
            self.serviceRegisterData(with: name, email: email!, password: password!, age: age!)
        }else {
            self.signUpView?.showErrorMsg(message: "Please Enter Valid Email and Password")
        }
    }
}
