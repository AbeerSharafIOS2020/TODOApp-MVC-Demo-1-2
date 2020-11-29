//
//  ProfileView.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/24/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileView: UITableView{
    //MARK:- Outlets
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var updateProfileLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameIconImgView: UIImageView!
    @IBOutlet weak var emailIconImgView: UIImageView!
    @IBOutlet weak var ageIconeImgView: UIImageView!
    @IBOutlet weak var dateUserIconImgView: UIImageView!
    @IBOutlet weak var dateOfUpdateProfileImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateOfCreateUserLabel: UILabel!
    @IBOutlet weak var dateOfUpdateProfileLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    // MARK:- Properties
      let imagePicker = UIImagePickerController()
    //  let image = Data()
    // MARK:- Public Method
    func setup(){
        self.setupBackGround()
        self.labelConfigruation()
        self.setupLogoutButton()
        self.UserImagesConfigruation()
        self.addBackground()
        self.imageConfiguration()
    }
    func addImag(imageData: Data){
        let retreivedImage = UIImage(data: imageData)
        self.profileImgView?.image = retreivedImage
    }

    
}
// MARK:- Private Method
extension ProfileView {
    private func setupBackGround(){
        self.backgroundColor = Colors.primaryColor
        self.separatorStyle = .singleLine
        self.separatorColor = Colors.placholderColor
    }
    private func labelConfigruation(){
        setupLabel(updateProfileLabel,LabelText.editProfileLabel)
        setupLabel(userNameLabel,"" )
        setupLabel(emailLabel, "")
        setupLabel(ageLabel, "" )
        setupLabel(dateOfCreateUserLabel, "")
        setupLabel(dateOfUpdateProfileLabel,"" )
    }
    private func setupLabel(_ label: UILabel,_ text: String){
        label.text = text
        label.textColor = Colors.primaryColor
        label.font.withSize(16)
    }
    private func setupLogoutButton(){
        logoutLabel.backgroundColor = Colors.primaryColor
        logoutLabel.frame = CGRect(x: 48, y: 432, width: 304, height: 50)
        logoutLabel.tintColor = .white
        logoutLabel.layer.cornerRadius = logoutLabel.frame.height / 5
        logoutLabel.text = LabelText.logOutLabel
        logoutLabel.textColor = Colors.placholderColor
        logoutLabel.font.withSize(16)
    }
    private func UserImagesConfigruation(){
        self.setupUserImages(profileImgView,  UIImage(named: ImagesName.userEmailcon)!)
        self.setupUserImages(emailIconImgView,  UIImage(named: ImagesName.userEmailcon)!)
        self.setupUserImages(nameIconImgView,  UIImage(named: ImagesName.userNameIcon)!)
        self.setupUserImages(ageIconeImgView,  UIImage(named: ImagesName.userAgeIcon)!)
        self.setupUserImages(dateUserIconImgView,  UIImage(named: ImagesName.profileDateIcon)!)
        self.setupUserImages(dateOfUpdateProfileImgView,  UIImage(named: ImagesName.profileUpdateDateIcon)!)
    }
    private func addBackground(){
        // Add a background view to the table view
        let backgroundImage = UIImage(named: ImagesName.backgroundImage)
        let imageView = UIImageView(image: backgroundImage)
        self.backgroundView = imageView
    }
    private func setupUserImages(_ imagViewe: UIImageView!,_ image1: UIImage = UIImage(named: ImagesName.userNameIcon)!){
        imagViewe.image = image1
        imagViewe.layer.cornerRadius = profileImgView.frame.height / 2
        imagViewe.contentMode = .scaleToFill
        imagViewe.layer.borderColor = Colors.placholderColor.cgColor
        imagViewe.layer.borderWidth = 2.0
    }
    private func imageConfiguration() {
        self.profileImgView?.clipsToBounds = true
        self.imageLabel.isHidden = true
        self.profileImgView.image = UIImage(named: ImagesName.backgroundImage)
        self.profileImgView.contentMode =  .scaleToFill
    }
}



