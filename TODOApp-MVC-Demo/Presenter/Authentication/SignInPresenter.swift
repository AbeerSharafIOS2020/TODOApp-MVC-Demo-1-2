//
//  SignInPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol of SignInVCPresenter
protocol SignInVCPresenterDelegate: class {
    associatedtype View
    func onViewDidLoad(view : View)
    func tryLogin(email: String?, password: String?)
}
//MARK:- SignInPresenter
class SignInPresenter: SignInVCPresenterDelegate {
    //MARK:- Properties
    typealias View = MainViewProtocol
    private var loginView : MainViewProtocol?
    weak var validator : Validator!
    init(validator: Validator) {
        self.validator = validator
    }
    //MARK:- Private Methods
    private func validateField(email: String?, password: String?) -> Bool{
        if !validator.isValidEmail(email){
            return false
        }
        if !validator.isValidPassword(password){
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
extension SignInPresenter {
    //MARK:-  Handle Response
    private func serviceLogin(with email: String?, password: String?) {
        UserDefaultsManager.shared().token = nil
        UserDefaultsManager.shared().userID = nil
        self.loginView?.processOnStart()
        APIManager.login(email: email!, password: password!) { (response) in
            switch response {
            case .success(let result):
                let result = result
                self.userDefaultsData(isLogin: true, token: result.token,userID: result.user.id, name: result.user.name )
                AppDelegate.shared().switchToMainState()
            case .failure(let error):
                print(error.localizedDescription)
                self.loginView?.showErrorMsg(message: "\(error.localizedDescription)")
            }
            self.loginView?.processOnStop()
        }
    }
    //MARK:- The confirm of the SignInVCPresenterDelegate Protocol
    internal func onViewDidLoad(view : MainViewProtocol){
        self.loginView = view
    }
    func tryLogin(email: String?, password: String?) {
        if validateField(email: email, password: password){
            self.serviceLogin(with: email!, password: password!)
        }else {
            self.loginView?.showErrorMsg(message: "Please Enter Valid Email and Password")
        }
    }
}
