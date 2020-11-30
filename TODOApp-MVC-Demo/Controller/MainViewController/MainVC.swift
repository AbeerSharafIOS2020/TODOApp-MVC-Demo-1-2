//
//  MainViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/30/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
//MARK:- Protocol
protocol MainVCProtocol: class {
    func showErrorMsg(message: String)
    func showSuccessMsg(message: String)
    func processOnStart()
    func processOnStop()
    func confirmationAlert1(title: String,message: String)
    func showAlertWithTwoActions(title: String, message: String, firstBtn: UIAlertAction)
}
class MainVC: UIViewController {
    // MARK:- Outlets
    // MARK:- Lifecycle methods
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    //MARK:- Public Methods
    func navigationStyle(){
        navigationController?.navigationBar.barTintColor = Colors.primaryColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
//MARK:- Extension
// Confirm protocol
extension MainVC: MainVCProtocol {
    func confirmationAlert1(title: String,message: String){
        let okAction =  UIAlertAction(title: "Yes", style: .default, handler: nil)
        self.confirmationAlert(title: title, message: message, firstBtn: okAction)
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
    func showAlertWithTwoActions(title: String, message: String, firstBtn: UIAlertAction){
        self.showCustomAlertWithAction(title: title, message: message, firstBtn: firstBtn)
    }
}
