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
  // MARK:- Public Method
    func setup(){
        self.setupBackGround()
        self.setupLogoutButton()
        self.setupUserImages()
        self.setupLabel()
    }
}
    // MARK:- Private Method
    extension ProfileView {
         private func setupBackGround(){
            self.backgroundColor = Colors.primaryColor
        }
        private func setupLabel(){
            updateProfileLabel.text = "Edit Profile"
            updateProfileLabel.textColor = Colors.primaryColor
            updateProfileLabel.font.withSize(16)
            
            userNameLabel.textColor = Colors.primaryColor
            userNameLabel.font.withSize(16)
            
            emailLabel.textColor = Colors.primaryColor
            emailLabel.font.withSize(16)
            
            ageLabel.textColor = Colors.primaryColor
            ageLabel.font.withSize(16)
            
            dateOfCreateUserLabel.textColor = Colors.primaryColor
            dateOfCreateUserLabel.font.withSize(16)
            dateOfUpdateProfileLabel.textColor = Colors.placholderColor
            dateOfUpdateProfileLabel.font.withSize(16)
        }
        private func setupLogoutButton(){
            logoutLabel.backgroundColor = Colors.primaryColor
            logoutLabel.frame = CGRect(x: 48, y: 432, width: 304, height: 50)

            logoutLabel.tintColor = .white
            
            logoutLabel.layer.cornerRadius = logoutLabel.frame.height / 5
            logoutLabel.text = "LOG OUT"
            logoutLabel.textColor = Colors.placholderColor
            logoutLabel.font.withSize(16)

            
        }
        private func setupUserImages(){
            profileImgView.layer.cornerRadius = profileImgView.frame.height / 2
            profileImgView.contentMode = .scaleToFill
            profileImgView.layer.borderWidth = 2.0
            profileImgView.layer.borderColor = Colors.placholderColor.cgColor

            
            nameIconImgView.image = UIImage(named: ImagesName.userNameIcon)
            nameIconImgView.layer.cornerRadius = profileImgView.frame.height / 2
            nameIconImgView.contentMode = .scaleToFill
            nameIconImgView.layer.borderColor = Colors.placholderColor.cgColor
            nameIconImgView.layer.borderWidth = 2.0



            emailIconImgView.image = UIImage(named: ImagesName.userEmailcon)
            emailIconImgView.layer.cornerRadius = profileImgView.frame.height / 2
            emailIconImgView.contentMode = .scaleAspectFit
            emailIconImgView.layer.borderColor = Colors.placholderColor.cgColor
            emailIconImgView.layer.borderWidth = 2.0



            ageIconeImgView.image = UIImage(named: ImagesName.userAgeIcon)
            ageIconeImgView.layer.cornerRadius = profileImgView.frame.height / 2
            ageIconeImgView.contentMode = .scaleToFill
            ageIconeImgView.layer.borderColor = Colors.placholderColor.cgColor
            ageIconeImgView.layer.borderWidth = 2.0



            dateUserIconImgView.image = UIImage(named: ImagesName.profileDateIcon)
            dateUserIconImgView.layer.cornerRadius = profileImgView.frame.height / 2
            dateUserIconImgView.contentMode = .scaleToFill
            dateUserIconImgView.layer.borderColor = Colors.placholderColor.cgColor
            dateUserIconImgView.layer.borderWidth = 2.0



            dateOfUpdateProfileImgView.image = UIImage(named: ImagesName.profileUpdateDateIcon)
            dateOfUpdateProfileImgView.layer.cornerRadius = profileImgView.frame.height / 2
            dateOfUpdateProfileImgView.contentMode = .scaleToFill
            dateOfUpdateProfileImgView.layer.borderColor = Colors.primaryColor.cgColor
            dateOfUpdateProfileImgView.layer.borderWidth = 3.0



            
        }
        private func setupImages(){
            
            profileImgView.image = UIImage(named: ImagesName.backgroundImage)
            profileImgView.contentMode =  .scaleToFill
            
        }
            

    }



