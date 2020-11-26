    //
    //  SignInView.swift
    //  TODOApp-MVC-Demo
    //
    //  Created by AbeerSharaf on 11/22/20.
    //  Copyright © 2020 IDEAEG. All rights reserved.
    //
    
    import UIKit
    import SkyFloatingLabelTextField
    
    class SignInView: UIView {
        // MARK:- Outlets
        @IBOutlet weak var loginLabel: UILabel!
        @IBOutlet weak var loginImg: UIImageView!
        @IBOutlet weak var emailTxtField: SkyFloatingLabelTextFieldWithIcon!
        @IBOutlet weak var passTxtField: SkyFloatingLabelTextFieldWithIcon!
        @IBOutlet weak var signUpLabel: UILabel!
        @IBOutlet weak var noAccountLabel: UILabel!
        @IBOutlet weak var signInButton: PMSuperButton!
        
        // MARK:- Public Method
        func setup(){
            self.setupBackGround()
            self.setupTextField(emailTxtField, placeHolder: PlaceHolders.emailPlaceHolder, iconImage: UIImage(named: ImagesName.userEmailcon)!)
            self.setupTextField(passTxtField, placeHolder: PlaceHolders.passwordPlaceHolder, isSceure: true, iconImage: UIImage(named: ImagesName.passwordIcon)!)
            self.setupSignInButton()
            self.setupUserImage()
            self.setupLabel()
        }
    }
    // MARK:- Private Method
    extension SignInView {
        private func setupBackGround(){
            self.backgroundColor = Colors.primaryColor
        }
        private func setupLabel(){
            loginLabel.text = LabelText.loginLabel
            loginLabel.textColor = Colors.primaryColor
            loginLabel.font.withSize(26)
            signUpLabel.text = LabelText.signUpLabel
            signUpLabel.textColor = Colors.primaryColor
            signUpLabel.font.withSize(16)
            noAccountLabel.text = LabelText.noAccountLabel
            noAccountLabel.textColor = Colors.placholderColor
            noAccountLabel.font.withSize(16)
        }
        private func setupTextField(_ textField: SkyFloatingLabelTextFieldWithIcon, placeHolder: String, isSceure: Bool = false, isPhone: Bool = false, iconImage: UIImage){
            textField.backgroundColor = .clear
            textField.placeholder = placeHolder
            textField.placeholderColor = Colors.placholderColor
            textField.selectedTitleColor = Colors.placholderColor
            textField.textColor = Colors.primaryColor
            textField.selectedLineHeight = 1
            textField.iconType = IconType(rawValue: 1)!
            textField.iconColor = Colors.primaryColor
            textField.selectedIconColor = Colors.placholderColor
            textField.lineColor = Colors.placholderColor
            textField.selectedLineColor = Colors.primaryColor
            textField.font = UIFont.init(name: textField.font!.fontName, size: 20)
            textField.isSecureTextEntry = isSceure
            if isPhone {
                textField.keyboardType = .asciiCapableNumberPad
            }
        }
        private func setupSignInButton(){
            signInButton.backgroundColor = Colors.primaryColor
            signInButton.frame = CGRect(x: 48, y: 432, width: 304, height: 60)
            signInButton.tintColor = .white
            signInButton.layer.cornerRadius = signInButton.frame.height / 5
            signInButton.setTitle(Titles.loginTitle, for: .normal)
        }
        private func setupUserImage(){
            loginImg.image = UIImage(named: ImagesName.backgroundImage)
            loginImg.contentMode =  .scaleToFill
        }
    }
    
