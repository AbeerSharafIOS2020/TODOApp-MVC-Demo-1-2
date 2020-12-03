//
//  SignInPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol of SignInVCPresenter
// SignInViewModelProtocol -use by any class to provide login date
protocol SignInViewModelProtocol {
    // associatedtype View
    func onViewDidLoad(view : MainVCProtocol)
    func tryLogin(email: String?, password: String?)
}
//MARK:- SignInViewModel
class SignInViewModel {
    //MARK:- Properties
    weak var delegate: AuthNavigationDelegate?
    private weak var view : MainVCProtocol?
    weak var signInVC: SignInVC!
    init(signInVC: SignInVC) {
        self.signInVC = signInVC
    }
    //typealias View = MainVCProtocol
    //MARK:- Private Methods
    private func validateField(email: String?, password: String?) -> Bool{
        if !Validator.shared().isValidEmail(email){
            self.view?.showErrorMsg(message: Messages.emailErrorMsg)
            return false
        }
        if !Validator.shared().isValidPassword(password){
            self.view?.showErrorMsg(message: Messages.passwordErrorMsg)
            return false
        }
        return true
    }
}
//MARK:- extension
extension SignInViewModel: SignInViewModelProtocol  {
    //MARK:-  Handle Response
    private func serviceLogin(with email: String?, password: String?) {
       // UserDefaultsManager.shared().token = nil
        UserDefaultsManager.shared().userID = nil
        self.view?.processOnStart()
        APIManager.login(email: email!, password: password!) { (response) in
            switch response {
            case .success(let result):
                let result = result
                UserDefaultsManager.shared().isLogin = true
                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().userID = result.user.id
                UserDefaultsManager.shared().name = result.user.name
                self.delegate?.showMainState()
               // AppDelegate.shared().switchToMainState()
                print("token is : \(result.token)")
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showErrorMsg(message: "\(error.localizedDescription)")
            }
            self.view?.processOnStop()
        }
    }
    //MARK:- The confirm of the SignInVCPresenterDelegate Protocol
    internal func onViewDidLoad(view : MainVCProtocol){
        self.view = view
    }
    func tryLogin(email: String?, password: String?) {
        if validateField(email: email, password: password){
            self.serviceLogin(with: email!, password: password!)
        }else {
            self.view?.showErrorMsg(message: Messages.emailAndPassErrorMsg)
        }
    }
}
