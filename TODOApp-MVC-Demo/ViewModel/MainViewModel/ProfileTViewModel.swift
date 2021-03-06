//
//  ProfileTPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol
protocol ProfileTViewModelProtocol {
    func onViewDidLoad(view : MainVCProtocol)
    func tryLogOutConfirm()
    func serviceOfGetProfileData()
    func serviceOfGetImage()
    func tryUploadImage(_ imageData: Data)
    func loadImagByName()
    func ChooseSourceType()
    func confirmEdittingMsg(row: Int)
    func numberOfRowsInSection(_ section: Int) -> Int
}
//MARK:- ProfileTViewModel
class ProfileTViewModel {
    //MARK:- Properties
    weak var view : MainVCProtocol!
    init(view: MainVCProtocol) {
        self.view = view
    }
    weak var profileTVC: ProfileTVC!
    init(profileTVC: ProfileTVC) {
        self.profileTVC = profileTVC
    }
    //MARK:- Private Methods
    private func inValidEditing(_ txt: String){
        self.view?.showErrorMsg(message: "\(TitleMsg.invalid)  \(txt)\(Messages.tryAgainWithCorrect) \(txt)")
    }
    private func profileEdit(_ txt: String, _ editTxt: String){
        self.profileTVC?.presentSuccess(with: Messages.edittingDoneSuccessMsg)
        self.serviceUpdateProfile(txt, editTxt)
    }
    //Editting Alert
    private func edittingAlert(){
        self.profileTVC?.presentAlertWithActionSheet(title: TitleMsg.edittingSelection, message: Messages.editSelection, actions: [
            AlertableAction(title: AlertActionTitle.name, style: .default, result: true),
            AlertableAction(title: AlertActionTitle.email, style: .default, result: true),
            AlertableAction(title: AlertActionTitle.age, style: .default, result: true),
            AlertableAction(title: AlertActionTitle.password, style: .default, result: true),
            AlertableAction(title: AlertActionTitle.cancel, style: .default, result: false),
            ], completion: { [weak self] title in
                switch title {
                case AlertActionTitle.name :
                    self?.openAlert(AlertActionTitle.name)
                case AlertActionTitle.age :
                    self?.openAlert(AlertActionTitle.age)
                case AlertActionTitle.password :
                    self?.openAlert(AlertActionTitle.password)
                case AlertActionTitle.email :
                    self?.openAlert(AlertActionTitle.email)
                case AlertActionTitle.cancel :
                return
                default:
                    break
                }
            }
        )
    }
    private func editProfile(_ txt: String, _ editTxt: String){
        switch txt {
        case AlertActionTitle.name:
            if !((Validator.shared().isValidName(editTxt))){
                self.inValidEditing(txt.lowercased())
            }else {
                self.profileEdit(txt.lowercased(),editTxt)
            }
        case AlertActionTitle.email:
            if !((Validator.shared().isValidEmail(editTxt))){
                self.inValidEditing(txt.lowercased())
            }else {
                self.profileEdit(txt.lowercased(),editTxt)
            }
        case AlertActionTitle.password:
            if !((Validator.shared().isValidPassword(editTxt))){
                self.inValidEditing(txt.lowercased())
            }else {
                self.profileEdit(txt.lowercased(),editTxt)
            }
        case AlertActionTitle.age:
            if !((Validator.shared().isValidAge(Int(editTxt)))){
                self.inValidEditing(txt.lowercased())
            }else {
                self.profileEdit(txt.lowercased(),editTxt)
            }
        default:
            break
        }
    }
    //Open Alert
    private func openAlert(_ txt: String){
        profileTVC?.alertWithTextField(title: txt, message: "\(Messages.enterYourNew) \(txt.lowercased())", placeholder: "\(PlaceHolders.yourNew) \(txt.lowercased())") { result in
            self.editProfile(txt,"\(result)")
            print(result)
        }
    }
    private func deleteAllUserDefaultData(){
        UserDefaultsManager.shared().isLogin = false
        UserDefaultsManager.shared().token = nil
        UserDefaultsManager.shared().imagName = nil
        UserDefaultsManager.shared().isUploadImage = nil
        UserDefaultsManager.shared().name = nil
        UserDefaultsManager.shared().taskID = nil
        UserDefaultsManager.shared().userID = nil
    }
    //MARK:- Handle Response of Update Profile
    private func serviceUpdateProfile(_ txt: String,_ data: String){
        self.profileTVC.view?.processOnStart()
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
            self.profileTVC.view?.processOnStop()
        }
    }
    // MARK:- Handle Response of Log Out
    private func serviceOfLogout(){
        self.profileTVC.view?.processOnStart()
        APIManager.logout { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.deleteAllUserDefaultData()
                AppStateManager.shared().state = .auth
                print("logout: \(result)")
            }
            self.profileTVC.view?.processOnStop()
        }
    }
}
//MARK:- extension
extension ProfileTViewModel: ProfileTViewModelProtocol {
    //MARK:- Handle Response of Get Profile
    func serviceOfGetProfileData() {
        self.profileTVC.view?.processOnStart()
        APIManager.getProfile { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showErrorMsg(message: error.localizedDescription)
            case .success(let result):
                let result = result.user
                print("profile: \(result)")
                UserDefaultsManager.shared().userID = result.id
                self.profileTVC.profileView.ageLabel.text = "\(result.age)"
                self.profileTVC.profileView.dateOfCreateUserLabel.text = "\(result.createdAt)"
                self.profileTVC.profileView.emailLabel.text = "\(result.email)"
                self.profileTVC.profileView.userNameLabel.text = "\(result.name)"
                self.profileTVC.profileView.dateOfUpdateProfileLabel.text = "\(result.updatedAt)"
                self.profileTVC.view?.processOnStop()
                UserDefaultsManager.shared().name = "\(result.name)"
                Validator.shared().createImageByName()
                print("\(String(describing: UserDefaultsManager.shared().userID))")
            }
            self.view?.processOnStop()
        }
    }
    //MARK:- Handle Response of Get user image
     func serviceOfGetImage(){
        self.profileTVC.view?.processOnStart()
        print("is uploadimg:\(String(describing: UserDefaultsManager.shared().isUploadImage))")
        let id = "\(UserDefaultsManager.shared().userID ?? "")"
        print("id : \(id)")
        APIManager.getUserImage(id) { (response) in
            switch response {
            case .success(let result):
                let imageData = result.image
                print("\(result.image)")
                self.profileTVC?.profileView.addImag(imageData: imageData)
            case .failure(let error):
                print(error.localizedDescription)
                self.loadImagByName()
            }
            self.profileTVC.view?.processOnStop()
        }
    }
    //MARK:- Handle Response of Upload user image
     func tryUploadImage(_ imageData: Data){
        self.view?.processOnStart()
        APIManager.uploadPhoto(with: imageData, completion: { _ in ()
            guard imageData != nil else {return}
        })
        self.profileTVC.view?.processOnStop()
        UserDefaultsManager.shared().isUploadImage = true
    }
    //MARK:- The confirm of the ProfileTViewModelProtocol Protocol
     func onViewDidLoad(view : MainVCProtocol){
        self.view = view
    }
     func numberOfRowsInSection(_ section: Int) -> Int{
        if section == 0 {
            return 6
        }else if section == 1 {
            return 1
        }
        return 6
    }
    //Load image by name to the profile image
     func loadImagByName(){
        self.profileTVC?.profileView.imageLabel.isHidden = false
        if UserDefaultsManager.shared().imagName != nil {
            self.profileTVC?.profileView.imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
            print("if is not nil \(UserDefaultsManager.shared().imagName ?? "")")
        }else {
            Validator.shared().createImageByName()
            self.profileTVC.profileView.imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
            print("if is nil \(UserDefaultsManager.shared().imagName ?? "")")
        }
    }
    //MARK:- tryLogOutConfirm()
     func tryLogOutConfirm(){
        self.profileTVC.presentAlert(title: TitleMsg.confirm, message: Messages.confirmLogout,
                                     actions: [
                                        AlertableAction(title: AlertActionTitle.no, style: .cancel, result: false),
                                        AlertableAction(title: AlertActionTitle.yes, style: .destructive, result: true),
            ],
                                     completion: { [weak self] result in
                                        guard result else { return }
                                        self?.serviceOfLogout()
            }
        )
    }
    //MARK:- ChooseSourceType action sheet
     func ChooseSourceType(){   self.profileTVC.presentAlertWithActionSheet(title: TitleMsg.imageSelection, message: Messages.howToPickedImageMsg, actions: [
        AlertableAction(title: AlertActionTitle.camera, style: .default, result: true),
        AlertableAction(title: AlertActionTitle.photoAlbum, style: .default, result: true),
        AlertableAction(title: AlertActionTitle.cancel, style: .default, result: false),
        ], completion: { [weak self] title in
            switch title {
            case AlertActionTitle.camera :
                self!.profileTVC?.sourceType(.camera)
            case AlertActionTitle.photoAlbum :
                self!.profileTVC?.sourceType(.photoLibrary)
            case AlertActionTitle.cancel :
            return
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
            self.profileTVC.presentAlert(title: TitleMsg.profileEditting , message: Messages.edittingMsg ,
                                         actions: [
                                            AlertableAction(title: AlertActionTitle.no, style: .cancel, result: false),
                                            AlertableAction(title: AlertActionTitle.yes, style: .destructive, result: true),
                ],
                                         completion: { [weak self] result in
                                            guard result else { return }
                                            self?.edittingAlert()
                }
            )
        }
    }
}
