//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit


class SignInVC: MainViewController {
    // MARK:- Outlite
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
        checkValidation(emailTxtField)
    }
    
    // Go to Sing UP
    @IBAction func goToSignUpScreenBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToRegisterState()
    }
    // MARK:- Validation Methods
    // check validation
    func  checkValidation(_ txtField: UITextField)  {
        if (emailTxtField.text!.isEmpty){
            
            emailTxtField.placeholder = "Enter your Email"
            emailTxtField.becomeFirstResponder()
            
        }else if (passTxtField.text!.isEmpty){
            passTxtField.placeholder = "Enter your Password"
            passTxtField.becomeFirstResponder()
        }else
            if !emailTxtField.text!.isEmail  {
                showAlert(message: "Enter valid email", title: "Error")
            } else {
                serviceLogin()
        }
    }
    // MARK:- Handle Response
    //check login data
    func serviceLogin() {
        processOnStart()
        let email = emailTxtField.text ?? ""
        let pass = passTxtField.text ?? ""
        APIManager.login(with: email , password: pass  ) {
            (error, loginData) in
            if let error = error {
                self.showAlert(message: "\(error.localizedDescription)", title: "Error")
                self.processOnStop()
                print(error.localizedDescription)
            } else if let loginData = loginData {
                self.processOnStop()
                print("token: \(loginData.token)")
                UserDefaultsManager.shared().token = loginData.token
                AppDelegate.shared().switchToMainState()
            }
        }
    }

    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        return signInVC
    }
}
