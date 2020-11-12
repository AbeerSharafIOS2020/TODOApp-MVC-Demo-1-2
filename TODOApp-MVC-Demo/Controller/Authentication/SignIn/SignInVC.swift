//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

protocol SignInVCDelegate: class {
    func validateData(email: String , password: String)
    func showErrorMsg(message: String)
    func showSuccessMsg(message: String)
    func processOnStart()
    func processOnStop()
}
class SignInVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var loginImagLabel: UILabel!
    //MARK:- Properties
    private var signInPresenter: SignInVCPresenterDelegate?
    

    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.viewDidLoad()
        signInPresenter?.onViewDidLoad(delegate: self)
        UserDefaultsManager.shared().isUploadImage = false
//        signInPresenter = SignInVCPresenter()
        //signInPresenter.self = self as! SignInVCPresenterDelegate
    }
    
    // MARK:- Actions Methods
    //Sign in Btn
    @IBAction func signInBtnPressed(_ sender: Any) {
        self.signInPresenter?.validateData(email: emailTxtField.text ?? "" , password: passTxtField.text ?? "")
//        if validation(emailTxtField.text, passTxtField.text) {
//            self.serviceLogin(with: emailTxtField.text, password: passTxtField.text)
//        }
    }
    
    // Go to Sing UP
    @IBAction func goToSignUpScreenBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToRegisterState()
    }
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        return signInVC
    }
}
// MARK:- Handle Response
//extension SignInVC {
//    //serviceLogin
//    private func serviceLogin(with email: String?, password: String?) {
//        //        UserDefaultsManager.shared().token = nil
//        //        UserDefaultsManager.shared().userID = nil
//        guard let email = email, self.isValidEmail(email) else {return}
//        guard let password = password, self.isValidPassword(password) else {return}
//        self.view.processOnStart()
//        APIManager.login(email: email, password: password) { (response) in
//            switch response {
//            case .success(let result):
//                let result = result
//                UserDefaultsManager.shared().isLogin = true
//                UserDefaultsManager.shared().token = result.token
//                UserDefaultsManager.shared().userID = result.user.id
//                UserDefaultsManager.shared().name = "\(result.user.name)"
//                //                self.createImageByName()
//                AppDelegate.shared().switchToMainState()
//            case .failure(let error):
//                print(error.localizedDescription)
//                self.presentError(with: error.localizedDescription)
//
//            }
//            self.view.processOnStop()
//        }
//    }
//}
//MARK:- extension for SignInVCPresenter delegate
extension SignInVC: SignInVCDelegate {
    func validateData(email: String, password: String) {
        self.signInPresenter?.validateData(email: email, password: password)
    }
    
    func showErrorMsg(message: String){
        self.presentError(with: message)
    }
    func showSuccessMsg(message: String){
        self.showAlert(message: message, title: "Success")

    }
    func processOnStart(){
        self.view.processOnStart()
    }
    func processOnStop(){
        self.view.processOnStop()
    }

}
