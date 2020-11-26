//
//  ProfileTPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol
protocol ProfileTPresenterProtocol: class {
    associatedtype View
    func onViewDidLoad(view : View)
    func tryLogOutConfirm()
    func serviceOfGetProfileData()
    func serviceOfGetImage()
    func tryUploadImage(_ imageData: Data)
    func loadImagByName()
    func ChooseSourceType()
    func confirmEdittingMsg(row: Int)
}
//MARK:- ProfileTPresenter
class ProfileTPresenter: ProfileTPresenterProtocol {
    //MARK:- Properties
    typealias View = MainViewProtocol
    private weak var view : MainViewProtocol?
    weak var mainVC : MainVC!
    init(mainVC: MainVC) {
        self.mainVC = mainVC
    }
    weak var profileTVC: ProfileTVC!
    init(profileTVC: ProfileTVC) {
        self.profileTVC = profileTVC
    }
    //MARK:- Private Methods
    private func editProfile(_ txt: String, _ editTxt: String){
        switch txt {
        case "Name":
            if !((self.mainVC?.isValidName(editTxt)) ?? false ){
                self.view?.showErrorMsg(message: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
            }else {
                self.profileTVC?.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        case "Email":
            if !((self.mainVC?.isValidEmail(editTxt)) ?? false ){
                self.view?.showErrorMsg(message: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
            }else {
                self.profileTVC?.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        case "Password":
            if !((self.mainVC?.isValidPassword(editTxt)) ?? false){
                self.view?.showErrorMsg(message: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
                
            }else {
                self.profileTVC?.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        case "Age":
            if !((self.mainVC?.isValidAge(Int(editTxt))) ?? false ){
                self.view?.showErrorMsg(message: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
            }else {
                self.profileTVC?.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        default:
            break
        }
    }
    
    
}
//MARK:- extension
extension ProfileTPresenter {
    //MARK:- Handle Response of Get Profile
    func serviceOfGetProfileData() {
        self.view?.processOnStart()
        APIManager.getProfile { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showErrorMsg(message: error.localizedDescription)
            case .success(let result):
                let result = result.user
                print("profile: \(result)")
                self.profileTVC.profileView.ageLabel.text = "\(result.age)"
                self.profileTVC.profileView.dateOfCreateUserLabel.text = "\(result.createdAt)"
                self.profileTVC.profileView.emailLabel.text = "\(result.email)"
                self.profileTVC.profileView.userNameLabel.text = "\(result.name)"
                self.profileTVC.profileView.dateOfUpdateProfileLabel.text = "\(result.updatedAt)"
                self.view?.processOnStop()
                UserDefaultsManager.shared().name = "\(result.name)"
                Validator().createImageByName()
            }
            self.view?.processOnStop()
        }
    }
    //MARK:- Handle Response of Update Profile
    func serviceUpdateProfile(_ txt: String,_ data: String){
        self.view?.processOnStart()
        ParameterKeys.edit = txt
        APIManager.updateProfile(data: data){ (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showErrorMsg(message:  error.localizedDescription)
            case .success(let result):
                let result = result.user
                print("profile: \(result)")
                self.serviceOfGetProfileData()
            }
            self.view?.processOnStop()
        }
    }
    
    //MARK:- Handle Response of Get user image
    func serviceOfGetImage(){
        self.view?.processOnStart()
        print("is uploadimg:\(String(describing: UserDefaultsManager.shared().isUploadImage))")
        let id = "\(UserDefaultsManager.shared().userID ?? "")"
        print("id : \(id)")
        APIManager.getUserImage(id) { (response) in
            switch response {
            case .success(let result):
                let imageData = result.image
                self.profileTVC?.addImag(imageData: imageData)
                
            case .failure(let error):
                print(error.localizedDescription)
                self.loadImagByName()
            }
            self.view?.processOnStop()
        }
    }
    //MARK:- Handle Response of Upload user image
    func tryUploadImage(_ imageData: Data){
        self.view?.processOnStart()
        APIManager.uploadPhoto(with: imageData, completion: { _ in ()
            guard imageData != nil else {
                return
            }
        })
        self.view?.processOnStop()
        UserDefaultsManager.shared().imagName = nil
        UserDefaultsManager.shared().isUploadImage = true
    }
    // MARK:- Handle Response of Log Out
    func serviceOfLogout(){
        self.view?.processOnStart()
        APIManager.logout { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                UserDefaultsManager.shared().token = nil
                UserDefaultsManager.shared().isLogin = false
                AppDelegate.shared().switchToAuthState()
                print("logout: \(result)")
            }
            self.view?.processOnStop()
        }
    }
    
    //MARK:- The confirm of the SignInVCPresenterDelegate Protocol
    func onViewDidLoad(view : MainViewProtocol){
        self.view = view
    }
    
    //Load image by name to the profile image
    func loadImagByName(){
        self.profileTVC.profileView.imageLabel.isHidden = false
        if UserDefaultsManager.shared().imagName != nil {
            self.profileTVC.profileView.imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
            print("if is not nil \(UserDefaultsManager.shared().imagName ?? "")")
        }else {
            Validator().createImageByName()
            self.profileTVC.profileView.imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
            print("if is nil \(UserDefaultsManager.shared().imagName ?? "")")
            
        }
    }
    //MARK:- tryLogOutConfirm()
    func tryLogOutConfirm(){
        self.profileTVC.presentAlert(title: "Confirm", message: "Are you sure Do you want log out?",
                                     actions: [
                                        AlertableAction(title: "No", style: .cancel, result: false),
                                        AlertableAction(title: "Yes", style: .destructive, result: true),
            ],
                                     completion: { [weak self] result in
                                        guard result else { return }
                                        self?.serviceOfLogout()
            }
        )
    }
    //MARK:- ChooseSourceType action sheet
    func ChooseSourceType(){   self.profileTVC.presentAlertWithActionSheet(title: "Image Selection", message: "From where you want to pick this image?", actions: [
        AlertableAction(title: "Camera", style: .default, result: true),
        AlertableAction(title: "Photo Album", style: .default, result: true),
        AlertableAction(title: "Cancel", style: .default, result: false),
        ], completion: { [weak self] title in
            switch title {
            case "Camera" :
                self?.profileTVC.imagePicker.sourceType = .camera
                self?.profileTVC.imagePicker.allowsEditing = true
                self?.profileTVC.present(self!.profileTVC.imagePicker, animated: true, completion: nil)
                
            case "Photo Album" :
                self?.profileTVC.imagePicker.sourceType = .photoLibrary
                self?.profileTVC.imagePicker.allowsEditing = true
                self?.profileTVC.present(self!.profileTVC.imagePicker, animated: true, completion: nil)
            case "Cancel" :
            return //self.present(alert, animated: true, completion: nil)
            default:
                break
            }
        }
        
        )
    }
    //MARK:- Setup EditAlert + open text alert
    //Confirm Editting Alert
    func confirmEdittingMsg(row: Int){
        if row == 0 {
            self.profileTVC.presentAlert(title: "Profile Editting", message: "Are you sure , Do you want to edit your profile?",
                                         actions: [
                                            AlertableAction(title: "No", style: .cancel, result: false),
                                            AlertableAction(title: "Yes", style: .destructive, result: true),
                ],
                                         completion: { [weak self] result in
                                            guard result else { return }
                                            self?.edittingAlert()
                }
            )
        }
    }
    //Editting Alert
    func edittingAlert(){
      self.profileTVC?.presentAlertWithActionSheet(title: "Editting Selection", message: "please...press what do you whant to edit it?", actions: [
            AlertableAction(title: "Name", style: .default, result: true),
            AlertableAction(title: "Email", style: .default, result: true),
            AlertableAction(title: "Password", style: .default, result: true),
            AlertableAction(title: "Age", style: .default, result: true),
            AlertableAction(title: "Cancel", style: .default, result: false),
            ], completion: { [weak self] title in
                switch title {
                case "Name" :
                    self?.openAlert("Name")
                case "Email" :
                    self?.openAlert("Email")
                    
                case "Password" :
                    self?.openAlert("Password")
                    
                case "Age" :
                    self?.openAlert("Age")
                case "Cancel" :
                return //self.present(alert, animated: true, completion: nil)
                default:
                    break
                }
                
            }
        )
        
    }
    
    //Open Alert
    func openAlert(_ txt: String){
        self.profileTVC.alertWithTextField(title: txt, message: "Enter your new \(txt.lowercased())", placeholder: "your new \(txt.lowercased())") { result in
            self.editProfile(txt,"\(result)")
            print(result)
        }
    }
    
}
