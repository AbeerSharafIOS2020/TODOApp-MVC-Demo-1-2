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
    //MARK:-Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageConfiguration()
        //loadIoginImag()
        serviceOfGetProfileData()
        serviceOfGetImage()
    }
    //MARK:-Actions Methods :
    //log out Btn
    @IBAction func logoutBtnPressed(_ sender: Any) {
        confirmLogOut()
    }
    
    @IBAction func addImagBtnTapPressed(_ sender: Any) {
        self.ChooseSourceType()
        //        self.save()
    }
    //Back Btn
    @IBAction func backTapButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row % 2 == 0
        {
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
        }
        else
        {
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
            confirmEdittingMsg()
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
    //MARK:-Private Methods
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
    private func confirmEdittingMsg(){
        let okAction = UIAlertAction(title: "Yes", style: .default) {
            (UIAlertAction) in
            print("ok")
            self.edittingAlert()
        }
        showCustomAlertWithAction(title: "Profile Editting", message: "Are you sure , Do you want to edit your profile?", firstBtn: okAction)
        
    }
    private func  confirmLogOut(){
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (UIAlertAction) in
            print("ok")
            self.serviceOfLogout()
        }
        showCustomAlertWithAction(title: "Log Out", message: "Are you sure Do you want log out?", firstBtn: okAction)
    }
    // MARK:- Handle Response of Log Out
    private func serviceOfLogout(){
        self.view.processOnStart()
        APIManager.logout { (error, logOut) in
            if let error = error {
                self.presentError(with: error.localizedDescription)
            } else if let logOut = logOut {
                UserDefaultsManager.shared().token = nil
                UserDefaultsManager.shared().isLogin = false
                
                AppDelegate.shared().switchToAuthState()
                print("profile: \(logOut)")
            }
            self.view.processOnStop()
        }
    }
    //MARK:- Handle Response of Get Profile
    
    private func serviceOfGetProfileData() {
        self.view.processOnStart()
        APIManager.g { (error, response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
                self.presentError(with: error.localizedDescription)
            case .success(let result):
                if let result = result. {
                print("profile: \(profile)")
                self.ageLabel.text = "\(profile.age)"
                self.dateOfCreateUserLabel.text = "\(profile.createdAt)"
                self.emailLabel.text = "\(profile.email)"
                self.userNameLabel.text = "\(profile.name)"
                self.dateOfUpdateProfileLabel.text = "\(profile.updatedAt)"
            }
            self.view.processOnStop()
        }
    }
    private func serviceUpdateProfile(_ txt: String,_ data: String){
        self.view.processOnStart()
        ParameterKeys.edit = txt
        APIManager.updateProfile(data, completion: { (error, profile) in
            if let error = error {
                self.presentError(with: error.localizedDescription)
            } else if let profile = profile?.user {
                print("profile: \(profile)")
                self.serviceOfGetProfileData()
            }
            self.view.processOnStop()
        })
        
    }
    
    
    // MARK:- Public Methods
    class func create() -> ProfileTVC {
        let profileTVC: ProfileTVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileTVC)
        return profileTVC
    }
    //MARK:- Handle Response of Get user image
    private func serviceOfGetImage(){
        self.view.processOnStart()
        APIManager.getUserImage(completion: { (error, userImage,imageRes) in
            if let error = error {
                self.presentError(with: "in get imag: \(error.localizedDescription)")
            } else if let imageRes = imageRes{
                print("Success")
            }
            self.view.processOnStop()
        })
        
    }
    
    private func uploadImage(_ image: UIImage){
        self.view.processOnStart()
        APIManager.uploadImage(with: image, completion: { (error, success) in
                if let error = error {
                    self.presentError(with: "false in upload image  \(error.localizedDescription)")
                } else if let success = success?.success {
                    if success == true {
                    self.presentSuccess(with: "Upload the image Successfully")
                }
                self.view.processOnStop()
            }
            })
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
    private func loadIoginImag(){
        self.serviceOfGetImage()
        //        if UserDefaultsManager.shared().imagName != nil {
        //            imageLabel.text = "\(UserDefaultsManager.shared().imagName ?? "")"
        //        }else {
        //            imageLabel.isHidden = true
        //        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // This function is to catch file image from your photo library.
        //when i finished selected image from picker to handle value edited Image and non-edited Image, here is :
        self.dismiss(animated: true) { [weak self] in

            guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            
            self?.imageLabel.isHidden = true
            
            
            //Setting image to your image view
            self?.profileImg.image = profileImage
            let img = UIImage()
            self?.uploadImage(img)
            
            //Save image
            let data = img.jpegData(compressionQuality: 1)
            UserDefaults.standard.set(data, forKey: "myImageKey")
            UserDefaults.standard.synchronize()

            //Get image
            if (UserDefaults.standard.object(forKey: "myImageKey") as? Data) != nil {
                //let retrievedImg = UIImage(data: imgData as Data)
                print("get image")
                self?.serviceOfGetImage()
            }
////            // Convert to Data
////            if let data1 = image?.pngData() {
//                // Create URL
//                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//                print("doc: \(documents)")
//                let url = documents.appendingPathComponent("profileImage.png")
//                print("url: \(url)")
//                do {
//                    // Write to Disk
//                    try data1.write(to: url)
//
//                    // Store URL in User Defaults
//                    UserDefaults.standard.set(url, forKey: "profileImage")
//                    print("it is saved")
//
//                } catch {
//                    print("Unable to Write Data to Disk (\(error))")
//                }
        }
    }
    //MARK: - Saving Image here
    private func save() {
        guard let selectedImage = self.profileImg.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Save error")
            // we got back an error!
            self.showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            print("Your image has been saved to your photos.")
            self.showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }
    
    
    
    private func imageConfiguration(){
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
    
    //you need to adding delegate UIImagePickerController inside your function
    func handleProfilePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        // ....(your custom code for navigationBar in Picker color)
        self.present(picker,animated: true,completion: nil)
    }
    
    
    
    
    
    
    
}
