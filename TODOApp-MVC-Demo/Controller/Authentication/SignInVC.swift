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
    @IBOutlet weak var loginImagLabel: UILabel!

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
}
    // MARK:- Handle Response
    extension SignInVC {
    //serviceLogin
    private func serviceLogin(with email: String?, password: String?) {
        UserDefaultsManager.shared().userID = nil
        guard let email = email, self.isValidEmail(email) else {return}
        guard let password = password, self.isValidPassword(password) else {return}
        self.view.processOnStart()
        APIManager.login(email: email, password: password) { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.presentError(with: error.localizedDescription)
            case .success(let result):
                UserDefaultsManager.shared().isLogin = true
                UserDefaultsManager.shared().token = result.token
                UserDefaultsManager.shared().userID = result.user.id
                UserDefaultsManager.shared().name = "\(result.user.name)"
                self.createImageByName()
                AppDelegate.shared().switchToMainState()
            }
            self.view.processOnStop()
        }
    }
}
