//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

//MARK:- Protocol  of view of sign in
protocol SignInVCDelegate: class {
    func showErrorMsg(message: String)
    func showSuccessMsg(message: String)
    func processOnStart()
    func processOnStop()
}
class SignInVC: MainViewController {
    // MARK:- Outlets
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var loginImagLabel: UILabel!
    //MARK:- Properties
    private var signInPresenter: SignInVCPresenter?
    var validator: Validator!
   
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signInPresenter = SignInVCPresenter(validator: validator)
        self.signInPresenter?.onViewDidLoad(view: self)
        UserDefaultsManager.shared().isUploadImage = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK:- Actions Methods
    //Sign in Btn
    @IBAction func signInBtnPressed(_ sender: Any) {
        self.signInPresenter?.validateData(email: emailTxtField.text ?? "" , password: passTxtField.text ?? "")
    }
    
    // Go to Sing UP
    @IBAction func goToSignUpScreenBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToRegisterState()
    }
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.validator = Validator(view: signInVC)
        return signInVC
    }
}
//MARK:- extension that confirm the SignInVCDelegate Protocol
extension SignInVC: SignInVCDelegate {
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
