//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpVC: MainViewController {
       // MARK:- Outlets
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpImg: UIImageView!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var userAgeTxtField: UITextField!
    @IBOutlet weak var signInLabel: UILabel!

    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- Actions Methods
    //Sign Up Btn
    @IBAction func signUpBtnPressed(_ sender: Any) {
        if self.validation() {
        serviceRegisterData()
        }
        
    }
    
    //Go to Sign In
    @IBAction func goToSignInScreenBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToAuthState()
    }
    
    // MARK:- Validation  Methods
    // is Empty
//    func fullTxtField() {
//        if (userNameTxtField.text!.isEmpty){
//
//            userNameTxtField.placeholder = "Enter your Name"
//            userNameTxtField.becomeFirstResponder()
//
//        } else if (emailTxtField.text!.isEmpty){
//
//            emailTxtField.placeholder = "Enter your Email"
//            emailTxtField.becomeFirstResponder()
//
//        } else if (passTxtField.text!.isEmpty){
//
//            passTxtField.placeholder = "Enter your Password"
//            passTxtField.becomeFirstResponder()
//
//        }else if (userAgeTxtField.text!.isEmpty){
//
//            userAgeTxtField.placeholder = "Enter your age"
//            userAgeTxtField.becomeFirstResponder()
//        } else {
//            userValidation()
//        }
//    }
    // is valid
//    func userValidation(){
//        if !isValidateName(userNameTxtField){
//            showAlert(message: "Enter valid name", title: "Error")
//            userNameTxtField.becomeFirstResponder()
//        }else if !emailTxtField.text!.isEmail  {
//            showAlert(message: "Enter valid email", title: "Error")
//            emailTxtField.becomeFirstResponder()
//            
//        } else if !isValidationPass(passTxtField) {
//            showAlert(message: "Enter valid password ,is shorter than the minimum allowed length (7) ", title: "Error")
//            passTxtField.becomeFirstResponder()
//            
//        } else if !isValidationAge(userAgeTxtField){
//            showAlert(message: "Enter valid age greater than 4 years ", title: "Error")
//            userAgeTxtField.becomeFirstResponder()
//            
//        } else {
//            UserDefaultsManager.shared().token = nil
//            serviceRegisterData()
//        }
//    }
    
    // MARK:- Handle Response
    
    func serviceRegisterData() {
        self.view.processOnStart()
        let name = userNameTxtField.text ?? ""
        let pass = passTxtField.text ?? ""
        let email = emailTxtField.text ?? ""
        let age = Int(userAgeTxtField.text ?? "") ?? 0
        UserDefaultsManager.shared().token = nil
        UserDefaultsManager.shared().imagName = nil
        APIManager.register(name: name, email: email, password: pass, age: age ) {
            (error, loginData) in
            if let error = error {
                self.view.processOnStop()
                self.presentError(with: error.localizedDescription)
            } else if let loginData = loginData {
                self.view.processOnStop()
                print(loginData.token)
                UserDefaultsManager.shared().token = loginData.token
                UserDefaultsManager.shared().isLogin = false
                let imageName = "\((loginData.user.name.first)?.uppercased() ?? "")"
                print("image: \(imageName) \((loginData.user.name.first)?.uppercased() ?? "" )")
                UserDefaultsManager.shared().imagName = "\(imageName)"
                AppDelegate.shared().switchToAuthState()
            }
        }
    }

    
    
    func validation()-> Bool {
        guard self.isValidName(userNameTxtField.text) else {return false}
        guard self.isValidEmail(emailTxtField.text) else {return false}
        guard self.isValidPassword(passTxtField.text) else {return false}
        guard self.isValidAge(Int(userAgeTxtField.text ?? "")) else {return false}
        return true
    }
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        return signUpVC
    }
}

