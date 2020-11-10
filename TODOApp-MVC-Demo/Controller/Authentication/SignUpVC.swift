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
                self.serviceRegisterData(with: userNameTxtField.text, email: emailTxtField.text, password: passTxtField.text, age: Int(userAgeTxtField.text ?? ""))
            }
        }
        //Go to Sign In
        @IBAction func goToSignInScreenBtnPressed(_ sender: Any) {
            AppDelegate.shared().switchToAuthState()
        }
        // MARK:- Public Methods
        class func create() -> SignUpVC {
            let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
            return signUpVC
        }
        //MARK:- Private Methods
        //Validation Method:
        private func validation()-> Bool {
            guard self.isValidName(userNameTxtField.text) else {return false}
            guard self.isValidEmail(emailTxtField.text) else {return false}
            guard self.isValidPassword(passTxtField.text) else {return false}
            guard self.isValidAge(Int(userAgeTxtField.text ?? "")) else {return false}
            return true
        }
    }
    // MARK:- Handle Response
    extension SignUpVC {
        //serviceRegisterData 
        private func serviceRegisterData(with name: String?, email: String?, password: String?, age: Int?) {
//            UserDefaultsManager.shared().token = nil
            UserDefaultsManager.shared().imagName = nil
            UserDefaultsManager.shared().userID = nil
            guard let name = name, self.isValidName(name) else {return}
            guard let password = password, self.isValidPassword(password) else {return}
            guard let email = email, self.isValidEmail(email) else {return}
            guard let age = age, self.isValidAge(age) else {return}
            self.view.processOnStart()
            APIManager.register(name: name, email: email, password: password, age: age ) {
                (response) in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                    self.presentError(with: error.localizedDescription)
                    self.view.processOnStop()
                case .success(let result):
                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().isLogin = false
                UserDefaultsManager.shared().userID = result.user.id
                UserDefaultsManager.shared().name = "\(result.user.name)"
                self.createImageByName()
                AppDelegate.shared().switchToAuthState()
                }
                self.view.processOnStop()
            }
        }
    }
    
