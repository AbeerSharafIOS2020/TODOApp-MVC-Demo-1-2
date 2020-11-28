//
//  ADDTaskView.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/22/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ADDTaskView: UIView {
    // MARK:- Outlets
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var dataAndTimeTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var descriptionTxtField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var saveButton: PMSuperButton!
    @IBOutlet weak var imgBackimag: UIImageView!
    @IBOutlet weak var shadowView: ShadowView!
    
         // MARK:- Public Method
        func setup(){
            self.setupBackGround()
            self.setupTextField(descriptionTxtField, placeHolder: PlaceHolders.dateAndTimePlaceHolder)
            self.setupTextField(dataAndTimeTxtField, placeHolder: PlaceHolders.dateAndTimePlaceHolder)
            self.setupSaveButton()
            self.setupUserImage()
            self.setupTitle()
            self.setupShadowView()
        }
    }
        // MARK:- Private Method
        extension ADDTaskView {
             private func setupBackGround(){
              //self.backgroundColor = .clear 
            }
            private func setupTitle(){
                screenTitle.text = Titles.addTaskTitle
                screenTitle.textColor = Colors.primaryColor
                screenTitle.font.withSize(16)
            }
            private func setupShadowView(){
                shadowView.backgroundColor = .white
                shadowView.shadowColor = .white
                shadowView.layer.cornerRadius = 8
                shadowView.largeContentImage = UIImage(named: ImagesName.backgroundImage)
            }
            private func setupTextField(_ textField: SkyFloatingLabelTextFieldWithIcon, placeHolder: String, isSceure: Bool = false, isPhone: Bool = false){
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
            private func setupSaveButton(){
                saveButton.backgroundColor = Colors.primaryColor
                saveButton.frame = CGRect(x: 48, y: 432, width: 304, height: 60)
                saveButton.tintColor = .white
                saveButton.layer.cornerRadius = 5
                saveButton.setTitle(Titles.saveTitle, for: .normal)
            }
            private func setupUserImage(){
                imgBackimag.image = UIImage(named: ImagesName.backgroundImage)
                imgBackimag.contentMode =  .scaleAspectFit
                
            }
        }




