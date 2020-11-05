//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
class SignInVC: MainViewController {
    // MARK:- Outlets
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet var mainView: UIView!
    
    // MARK:- Constants & Variables

    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- Actions Methods
    //Sign in Btn
    @IBAction func signInBtnPressed(_ sender: Any) {
        if validation(emailTxtField.text, passTxtField.text) {
        self.serviceLogin(with: emailTxtField.text, password: passTxtField.text)
        }
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

    
//    // MARK:- Validation Methods
//    // check validation
//    func  checkValidation(_ txtField: UITextField)  {
//        if (emailTxtField.text!.isEmpty){
//
//            emailTxtField.placeholder = "Enter your Email"
//            emailTxtField.becomeFirstResponder()
//
//        }else if (passTxtField.text!.isEmpty){
//            passTxtField.placeholder = "Enter your Password"
//            passTxtField.becomeFirstResponder()
//        }else
//            if !emailTxtField.text!.isEmail  {
//                showAlert(message: "Enter valid email", title: "Error")
//            } else {
//                serviceLogin()
//        }
//    }

    // MARK:- Handle Response
    //check login data
    private func serviceLogin(with email: String?, password: String?) {
        guard let email = email, self.isValidEmail(email) else {return}
        guard let password = password, self.isValidPassword(password) else {return}
        self.view.processOnStart()
        APIManager.login(with: email , password: password, completion: { (error, loginData) in
            if let error = error {
                self.presentError(with:error.localizedDescription)
            } else if let loginData = loginData {
                print("token: \(loginData.token)")
                UserDefaultsManager.shared().token = loginData.token
                AppDelegate.shared().switchToMainState()
            }
            self.view.processOnStop()
        })
    }

    
}
