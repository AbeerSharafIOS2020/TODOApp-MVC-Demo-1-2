    //
    //  SignUpVC.swift
    //  TODOApp-MVC-Demo
    //
    //  Created by IDEAcademy on 10/27/20.
    //  Copyright © 2020 IDEAEG. All rights reserved.
    //
    
    import UIKit
    import SkyFloatingLabelTextField
    
    class SignUpVC: MainVC {
        // MARK:- Outlets
        @IBOutlet weak var signUpView: SignUpView!
        // MARK:- Properties
        var viewModel: SignUpViewModelProtocol!
        weak var delegate: ToDoListNavigationDelegate?
        // MARK:- Lifecycle methods
        override func viewDidLoad() {
            super.viewDidLoad()
            signUpView.setup()
            navigationStyle()
            self.viewModel?.onViewDidLoad(view: self)
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        // MARK:- Actions Methods
        //Sign Up Btn
        @IBAction func signUpBtnPressed(_ sender: Any) {
            self.viewModel?.trySignUp(name: signUpView.userNameTxtField.text, email: signUpView.emailTxtField.text, password: signUpView.passTxtField.text, age:signUpView.userAgeTxtField.text!)
        }
        //Go to Sign In
        @IBAction func goToSignInScreenBtnPressed(_ sender: Any) {
            self.navigationController?.popToRootViewController(animated: true)
         //   self.delegate?.showAuthState()
           // AppDelegate.shared().switchToAuthState()
        }
        // MARK:- Public Methods
        class func create() -> SignUpVC {
            let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
            signUpVC.viewModel = SignUpViewModel(signUpVC: signUpVC)
            return signUpVC
        }
    }
    
