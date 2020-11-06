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
        loadIoginImag()
        serviceOfGetProfileData()
    }
    //MARK:-Actions Methods :
    //log out Btn
    @IBAction func logoutBtnPressed(_ sender: Any) {
        confirmLogOut()
    }
    
    @IBAction func addImagBtnTapPressed(_ sender: Any) {
        self.ChooseSourceType()
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
    
    
    private func  confirmLogOut(){
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (UIAlertAction) in
            print("ok")
            self.serviceOfLogout()
        }
        showCustomAlertWithAction(title: "Log Out", message: "Are you sure you want To log out?", firstBtn: okAction)
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
    func serviceOfGetProfileData() {
        self.view.processOnStart()
        APIManager.getProfile { (error, profile) in
            if let error = error {
                self.presentError(with: error.localizedDescription)
            } else if let profile = profile?.user {
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
    // MARK:- Public Methods
    class func create() -> ProfileTVC {
        let profileTVC: ProfileTVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileTVC)
        return profileTVC
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
            //Setting image to your image view
            self?.profileImg.image = profileImage
//            uploadImage()
            // Load Image
            let image = UIImage(named: "profileImage")
            // Convert to Data
            if let data = image?.pngData() {
                // Create URL
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                print("doc: \(documents)")
                let url = documents.appendingPathComponent("profileImage.png")
                print("url: \(url)")
                do {
                    // Write to Disk
                    try data.write(to: url)

                    // Store URL in User Defaults
                    UserDefaults.standard.set(url, forKey: "profileImage")
                    print("it is saved")

                } catch {
                    print("Unable to Write Data to Disk (\(error))")
                }
            }
        }
    }
    private func imageConfiguration(){
        imagePicker.delegate = self
        profileImg?.layer.cornerRadius = (profileImg?.frame.size.width ?? 0.0) / 2
        profileImg?.clipsToBounds = true
        profileImg?.layer.borderWidth = 3.0
        profileImg?.layer.borderColor = UIColor.white.cgColor
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
