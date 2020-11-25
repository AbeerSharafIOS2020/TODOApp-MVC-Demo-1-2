//
//  SignUpView.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/22/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class SignUpView: UIView {
    // MARK:- Outlets
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpImg: UIImageView!
    @IBOutlet weak var userNameTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var emailTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var passTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var userAgeTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signUpButton: PMSuperButton!
     // MARK:- Public Method
       func setup(){
           self.setupBackGround()
           self.setupTextField(emailTxtField, placeHolder: "Email", iconImage: UIImage(named: "emailIcon")!)
          self.setupTextField(userNameTxtField, placeHolder: "Name", iconImage: UIImage(named: "userNameIcon")!)
        self.setupTextField(userAgeTxtField, placeHolder: "Age", iconImage: UIImage(named: "userNameIcon")!)
        
           self.setupTextField(passTxtField, placeHolder: "Password",isSceure: true, iconImage: UIImage(named: "passwordIcon")!)
           self.setupSignUpButton()
           self.setupUserImage()
           self.setupLabel()
       }
   }
       // MARK:- Private Method
       extension SignUpView {
            private func setupBackGround(){
               self.backgroundColor = Colors.primaryColor
           }
           private func setupLabel(){
               signInLabel.text = "Login"
               signInLabel.textColor = Colors.primaryColor
               signInLabel.font.withSize(16)
               signUpLabel.text = "Sign Up"
               signUpLabel.textColor = Colors.primaryColor
               signUpLabel.font.withSize(26)
               alreadyHaveAccountLabel.text = "Already have an account? "
               alreadyHaveAccountLabel.textColor = Colors.placholderColor
               alreadyHaveAccountLabel.font.withSize(16)
           }
           
           private func setupTextField(_ textField: SkyFloatingLabelTextFieldWithIcon, placeHolder: String, isSceure: Bool = false, isPhone: Bool = false, iconImage: UIImage){
               textField.backgroundColor = .clear
               textField.placeholder = placeHolder
               textField.placeholderColor = Colors.placholderColor
               textField.selectedTitleColor = Colors.placholderColor
               textField.textColor = Colors.primaryColor
               textField.selectedLineHeight = 1
               textField.iconType = IconType(rawValue: 1)!
               textField.iconColor = Colors.placholderColor
               textField.selectedIconColor = Colors.placholderColor
               textField.lineColor = Colors.placholderColor
               textField.selectedLineColor = Colors.primaryColor
               textField.font = UIFont.init(name: textField.font!.fontName, size: 20)
               textField.isSecureTextEntry = isSceure
               if isPhone {
                   textField.keyboardType = .asciiCapableNumberPad
               }
           }
           private func setupSignUpButton(){
               signUpButton.backgroundColor = Colors.primaryColor
               signUpButton.frame = CGRect(x: 48, y: 432, width: 304, height: 60)

               signUpButton.tintColor = .white
               
               signUpButton.layer.cornerRadius = signUpButton.frame.height / 5
               signUpButton.setTitle("Sign Up", for: .normal)
               
           }
           private func setupUserImage(){
               signUpImg.image = UIImage(named: "background")
               signUpImg.contentMode =  .scaleToFill
               
           }
       }



