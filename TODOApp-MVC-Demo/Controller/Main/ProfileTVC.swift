//
//  ProfileTVC.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {
    //MARK:- Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var updateProfileLabel: UILabel!
    @IBOutlet weak var nameIconImg: UIImageView!
    @IBOutlet weak var emailIconImg: UIImageView!
    @IBOutlet weak var ageIconeImg: UIImageView!
    @IBOutlet weak var dateUserIconImg: UIImageView!
    @IBOutlet weak var dateOfUpdateProfileImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var dateOfCreateUserLabel: UILabel!
    @IBOutlet weak var dateOfUpdateProfileLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    // MARK:- Properties
    let imagePicker = UIImagePickerController()
    let image = Data()
    //MARK:-Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageConfiguration()
        self.serviceOfGetProfileData()
        self.serviceOfGetImage()
    }
    //MARK:-Actions Methods :
    //log out Btn
    @IBAction func logoutBtnPressed(_ sender: Any) {
        confirmLogOut()
    }
    //add image Btn
    @IBAction func addImagBtnTapPressed(_ sender: Any) {
        self.ChooseSourceType()
    }
    //Back Btn
    @IBAction func backTapButton() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK:- Public Methods
    class func create() -> ProfileTVC {
        let profileTVC: ProfileTVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileTVC)
        return profileTVC
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row % 2 == 0{
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
        }else{
            cell.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)
        }
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.confirmEdittingMsg()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }else if section == 1 {
            return 1
        }
        return 6
    }
    //MARK:- Setup EditAlert
    private func edittingAlert(){
        let alert = UIAlertController(title: "Editting Selection", message: "please...press what do you whant to edit it?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Name", style: .default, handler: {(action: UIAlertAction) in
            self.openAlert("Name")
        }))
        alert.addAction(UIAlertAction(title: "Email", style: .default, handler: {(action: UIAlertAction) in
            self.openAlert("Email")
        }))
        alert.addAction(UIAlertAction(title: "Password", style: .default, handler: {(action: UIAlertAction) in
            self.openAlert("Password")
        }))
        alert.addAction(UIAlertAction(title: "Age", style: .default, handler: {(action: UIAlertAction) in
            self.openAlert("Age")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //Open Alert
    private func openAlert(_ txt: String){
        let alertController = UIAlertController(title: txt, message: "Enter your new \(txt.lowercased())", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "your new \(txt.lowercased())"
        }
        let saveAction = UIAlertAction(title: "Confirm", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    print("Text :: \(textField.text ?? "")")
                    self.editProfile(txt,"\(textField.text ?? "")")
                }else {
                    self.presentInfoMsg(with: "Enter you new \(txt.lowercased())")
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.preferredAction = saveAction
        
        self.present(alertController, animated: true, completion: nil)
    }
    //Confirm Editting Alert
    private func confirmEdittingMsg(){
        let okAction = UIAlertAction(title: "Yes", style: .default) {
            (UIAlertAction) in
            print("ok")
            self.edittingAlert()
        }
        showCustomAlertWithAction(title: "Profile Editting", message: "Are you sure , Do you want to edit your profile?", firstBtn: okAction)
        
    }
    //Confirm Logout Alert
    private func  confirmLogOut(){
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (UIAlertAction) in
            print("ok")
            self.serviceOfLogout()
        }
        showCustomAlertWithAction(title: "Log Out", message: "Are you sure Do you want log out?", firstBtn: okAction)
    }
    //MARK:- Private Methods:
    private func editProfile(_ txt: String, _ editTxt: String){
        switch txt {
        case "Name":
            if !(UI.mainViewController.isValidName(editTxt)){
                self.presentError(with: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
            }else {
                self.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        case "Email":
            if !(UI.mainViewController.isValidEmail(editTxt)){
                self.presentError(with: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
            }else {
                self.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        case "Password":
            if !(UI.mainViewController.isValidPassword(editTxt)){
                self.presentError(with: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
                
            }else {
                self.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        case "Age":
            if !(UI.mainViewController.isValidAge(Int(editTxt))){
                self.presentError(with: "Unvalid \(txt.lowercased())...try again with correct \(txt.lowercased())")
            }else {
                self.presentSuccess(with: "Editting Done Successfully..")
                self.serviceUpdateProfile(txt.lowercased(),editTxt)
            }
        default:
            break
        }
    }
}
//MARK:- extensions
extension ProfileTVC {
    // MARK:- Handle Response of Log Out
    private func serviceOfLogout(){
        self.view.processOnStart()
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
            self.view.processOnStop()
        }
    }
    //MARK:- Handle Response of Get Profile
    private func serviceOfGetProfileData() {
        self.view.processOnStart()
        APIManager.getProfile { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.presentError(with: error.localizedDescription)
            case .success(let result):
                let result = result.user
                print("profile: \(result)")
                self.ageLabel.text = "\(result.age)"
                self.dateOfCreateUserLabel.text = "\(result.createdAt)"
                self.emailLabel.text = "\(result.email)"
                self.userNameLabel.text = "\(result.name)"
                self.view.processOnStop()
                UserDefaultsManager.shared().name = "\(result.name)"
                UI.mainViewController.createImageByName()
                self.dateOfUpdateProfileLabel.text = "\(result.updatedAt)"
            }
            self.view.processOnStop()
        }
    }
    //MARK:- Handle Response of Update Profile
    private func serviceUpdateProfile(_ txt: String,_ data: String){
        self.view.processOnStart()
        ParameterKeys.edit = txt
        APIManager.updateProfile(data: data){ (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.presentError(with: error.localizedDescription)
            case .success(let result):
                let result = result.user
                print("profile: \(result)")
                self.serviceOfGetProfileData()
            }
            self.view.processOnStop()
        }
        
    }
    //MARK:- Handle Response of Get user image
    private func serviceOfGetImage(){
        if UserDefaultsManager.shared().isUploadImage == false {
            self.loadImagByName()
        } else {
            let id = "\(UserDefaultsManager.shared().userID ?? "")"
            self.view.processOnStart()
            self.view.processOnStart()
            APIManager.getProfilePhoto(with: id, completion: { (error,GetUserImageResponse, image) in
                if let error = error {
                    self.presentError(with: error.localizedDescription)
                } else if let dataImage = image {
                    let retreivedImage = UIImage(data: dataImage.image)
                    self.profileImg.image = retreivedImage
                }
                self.view.processOnStop()
            })
        }
    }
    //MARK:- Handle Response of Upload user image
    private  func uploadImage(_ image: UIImage){
        self.view.processOnStart()
        APIManager.uploadPhoto(with: image, completion: { _ in ()
            guard image.jpegData(compressionQuality: 1) != nil else {
                return
            }
        })
        self.view.processOnStop()
        UserDefaultsManager.shared().isUploadImage = true
    }
}
//MARK:- Image Picker
extension ProfileTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:- Private Methods
    private func ChooseSourceType(){
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    private func loadImagByName(){
        if UserDefaultsManager.shared().imagName != nil {
            imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
        }else {
            imageLabel.isHidden = true
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            
            self?.imageLabel.isHidden = true
            self?.profileImg.image = profileImage
            self?.uploadImage(profileImage)
        }
    }
    private func imageConfiguration() {
        imagePicker.delegate = self
        profileImg?.layer.cornerRadius = (profileImg?.frame.size.width ?? 0.0) / 2
        profileImg?.clipsToBounds = true
        profileImg?.layer.borderWidth = 3.0
        profileImg?.layer.borderColor = UIColor.white.cgColor
        imageLabel.isHidden = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}






