//
//  SignUpPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.

import Foundation
//MARK:- Protocol of SignUpViewModelProtocol
// SignUpViewModelProtocol -use by any class to provide sign up date
protocol SignUpViewModelProtocol {
    func onViewDidLoad(view : MainVCProtocol)
    func trySignUp(name: String?, email: String?, password: String?, age: String?)
}
//MARK:- SignUpViewModel
class SignUpViewModel {
    //MARK:- Properties
    private weak var view : MainVCProtocol?
    weak var signUpVC: SignUpVC!
    init(signUpVC: SignUpVC) {
        self.signUpVC = signUpVC
    }
    //MARK:- Private Methods
    private func validateField(name: String?, email: String?, password: String?, age:String?) -> Bool{
        if let emptyTextFeild = Validator.shared().notEmptyGetText(name: name, email: email, password: email, age: age){
            view?.confirmationAlert1(title: emptyTextFeild.0, message: emptyTextFeild.1)
            return false
        }else {
            if let notValidation = Validator.shared().getTextValidation(name: name, email: email, password: password, age: age) {
                view?.confirmationAlert1(title: notValidation.0, message: notValidation.1)
                return false
            }
        }
        return true
    }
}
//MARK:- extension
extension SignUpViewModel: SignUpViewModelProtocol {
    //MARK:-  Handle Response
    private func serviceRegisterData(with name: String?, email: String?, password: String?, age: Int?) {
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
                AppStateManager.shared().state = .auth
               // AppStateManager.shared().showAuthState()
            }
            self.view?.processOnStop()
        }
    }
    //MARK:- The confirm of the SignInVCPresenterDelegate Protocol
    internal func onViewDidLoad(view : MainVCProtocol){
        self.view = view
    }
    func trySignUp(name: String?, email: String?, password: String?, age: String?){
        if validateField(name: name, email: email, password: password, age: age){
            self.serviceRegisterData(with: name, email: email!, password: password!, age: Int(age!))}
    }
}
