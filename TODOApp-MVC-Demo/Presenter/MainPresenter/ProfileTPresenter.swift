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
    //func trySignUp(name: String?, email: String?, password: String?, age: Int?)
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
    weak var validator : Validator!
    init(validator: Validator) {
        self.validator = validator
    }
    //MARK:- Private Methods

//    private func validateField(name: String?, email: String?, password: String?, age:Int?) -> Bool{
//        if !validator.isValidName(name){
//            return false
//        }
//        if !validator.isValidEmail(email){
//            return false
//        }
//        if !validator.isValidPassword(password){
//            return false
//        }
//        if !validator.isValidAge(age){
//            return false
//        }
//        return true
//    }
    
//    private func userDefaultsData( isLogin: Bool, token: String, userID: String, name: String ){
//        UserDefaultsManager.shared().isLogin = isLogin
//        UserDefaultsManager.shared().token = token
//        UserDefaultsManager.shared().userID = userID
//        UserDefaultsManager.shared().name = name
//    }
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
                self.profileTVC.ageLabel.text = "\(result.age)"
                self.profileTVC.dateOfCreateUserLabel.text = "\(result.createdAt)"
                self.profileTVC.emailLabel.text = "\(result.email)"
                self.profileTVC.userNameLabel.text = "\(result.name)"
                self.profileTVC.dateOfUpdateProfileLabel.text = "\(result.updatedAt)"
                self.view?.processOnStop()
                UserDefaultsManager.shared().name = "\(result.name)"
                self.validator?.createImageByName()
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
            //                    self.presentError(with: error.localizedDescription)
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
        self.profileTVC.imageLabel.isHidden = false
        if UserDefaultsManager.shared().imagName != nil {
            self.profileTVC.imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
            print("if is not nil \(UserDefaultsManager.shared().imagName ?? "")")
        }else {
            self.validator?.createImageByName()
            self.profileTVC.imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
            print("if is nil \(UserDefaultsManager.shared().imagName ?? "")")
            
        }
    }
    
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


}

