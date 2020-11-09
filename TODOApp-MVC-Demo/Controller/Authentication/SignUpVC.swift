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
            self.serviceRegisterData()
        }
        
    }
    
    //Go to Sign In
    @IBAction func goToSignInScreenBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToAuthState()
    }
    
//    //MARK:- Private Methods
//    //create image by user name
//    private func createImageByName(_ name: String) {
//        let nameBuffer = name.split(separator: " ")
//        let firstName = nameBuffer[0]
//        let lastName = nameBuffer[1]
//        let imageByName = "\(firstName.first?.uppercased() ?? "" )\(lastName.first?.uppercased() ?? "")"
//        print("image: \(imageByName) )")
//        UserDefaultsManager.shared().imagName = "\(imageByName)"
//    }
    
   //Validation Method:
    private func validation()-> Bool {
        guard self.isValidName(userNameTxtField.text) else {return false}
        guard self.isValidEmail(emailTxtField.text) else {return false}
        guard self.isValidPassword(passTxtField.text) else {return false}
        guard self.isValidAge(Int(userAgeTxtField.text ?? "")) else {return false}
        return true
    }

    // MARK:- Handle Response
    //serviceRegisterData
    private func serviceRegisterData() {
        self.view.processOnStart()
        let name = userNameTxtField.text ?? ""
        let pass = passTxtField.text ?? ""
        let email = emailTxtField.text ?? ""
        let age = Int(userAgeTxtField.text ?? "") ?? 0
        UserDefaultsManager.shared().token = nil
        UserDefaultsManager.shared().imagName = nil
        UserDefaultsManager.shared().userID = nil

        APIManager.register(name: name, email: email, password: pass, age: age ) {
            (response) in
                switch response {
                case .failure(let error):
                   print(error.localizedDescription)
                   self.presentError(with: error.localizedDescription)
                case .success(let result):                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().isLogin = false
                UserDefaultsManager.shared().userID = result.user.id
                let name = "\(result.user.name)"
                self.createImageByName(name)
                AppDelegate.shared().switchToAuthState()
            }
        }
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        return signUpVC
    }
}

