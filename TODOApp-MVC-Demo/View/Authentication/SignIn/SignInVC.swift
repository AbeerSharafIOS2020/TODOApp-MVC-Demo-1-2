//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
// 1-
protocol AuthNavigationDelegate: class {
    func showMainState()
}
class SignInVC: MainVC {
    // MARK:- Outlets
    @IBOutlet weak var mainView: SignInView!
    //MARK:- Properties
    var signInViewModel: SignInViewModelProtocol!
    // 2-
    weak var delegate: AuthNavigationDelegate?
    // MARK:- Lifecycle methods
    override func viewDidLoad(){
        super.viewDidLoad()
        mainView.setup()
        navigationStyle()
        signInViewModel?.onViewDidLoad(view: self)
        UserDefaultsManager.shared().isUploadImage = false
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return  .lightContent
    }
    // MARK:- Actions Methods
    //Sign in Btn
    @IBAction func signInBtnPressed(_ sender: Any) {
        self.signInViewModel?.tryLogin(email:mainView.emailTxtField.text, password: mainView.passTxtField.text)
    }
    // Go to Sing UP
    @IBAction func goToSignUpScreenBtnPressed(_ sender: Any) {
        self.navigationController?
            .pushViewController(SignUpVC.create(), animated: true)
    }
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.signInViewModel = SignInViewModel(signInVC: signInVC)
        return signInVC
    }
}
extension SignInVC: AuthNavigationDelegate {
    func showMainState() {
        // 3-
        self.delegate?.showMainState()
    }
}
