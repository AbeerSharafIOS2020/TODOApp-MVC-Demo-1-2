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
protocol MainViewProtocol: class {
    func showErrorMsg(message: String)
    func showSuccessMsg(message: String)
    func processOnStart()
    func processOnStop()
    func confirmationAlert1(title: String,message: String)
    func showAlertWithTwoActions(title: String, message: String, firstBtn: UIAlertAction)
}

class MainVC: UIViewController {
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:- Public Methods
    // name validation
    func isValidName(_ name: String?) -> Bool {
        let nameTemp = name?.split(separator: " ")
        guard let name =  name?.trimmed, !name.isEmpty, nameTemp?.count ?? 0 >= 2, name.count  >= 2  else {
            self.presentError(with: "Enter Valid name ..at least consists two letters and first & last name")
               return false
           }
               return true
       }
    
    // password validation
  func isValidPassword(_ password: String?) -> Bool {
            guard let password = password, !password.isEmpty, password.count >= 8 else {
                self.presentError(with: "Password Must be at Least 8 Characters")
                return false
            }
            return true
        }
    func validation(_ email: String?, _ password: String? ) -> Bool{
        guard self.isValidEmail(email) else {return false}
        guard self.isValidPassword(password) else {return false}
        return true
    }

    //age validation
  func isValidAge(_ age: Int?) -> Bool {
    guard let age = age, String(age) != "" , age != 0 , age >= 10 else {
        self.presentError(with: "Enter valid age .. greater than or equal 10 years")
            return false
                  }
                      return true
                  }
    // MARK:- Private Methods
     func isValidEmail(_ email: String?) -> Bool {
        guard let email = email?.trimmed, !email.isEmpty else {
            self.presentError(with: "Please Enter an Email")
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if !pred.evaluate(with: email) {
            self.presentError(with: "Please Enter Valid Email")
            return false
        }
        return true
    }
    
    //create image by user name
     func createImageByName() {
        let name = "\(UserDefaultsManager.shared().name ?? "" )"
        var firstName = ""
        var lastName = ""
        print("name: \(name)")
        let nameBuffer = name.split(separator: " ")
        print("nameBuffer : \(nameBuffer)")
        if nameBuffer.count >= 2 {
            firstName = String(nameBuffer[0])
            lastName = String(nameBuffer[1])
        } else {
            firstName = String(nameBuffer[0])
        }
        let imageByName = "\(firstName.first?.uppercased() ?? "" )\(lastName.first?.uppercased() ?? "")"
        print("image: \(imageByName) )")
        UserDefaultsManager.shared().imagName = "\(imageByName)"
    }

}
//MARK:- Extension
extension MainVC: MainViewProtocol {
    
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