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
    @IBOutlet weak var profileView: ProfileView!
    // MARK:- Properties
    let imagePicker = UIImagePickerController()
    let image = Data()
    var profileTViewModel: ProfileTViewModel!
    weak var mainVC: MainVC!
    var validator: Validator!
    
    //MARK:-Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileView.backgroundColor = Colors.primaryColor
        self.profileViewSetUp()
        self.imageConfiguration()
        self.profileTViewModel?.serviceOfGetProfileData()
        self.profileTViewModel?.serviceOfGetImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:-Actions Methods :
    //log out Btn
    @IBAction func logoutBtnPressed(_ sender: Any) {
        self.profileTViewModel?.tryLogOutConfirm()
    }
    //add image Btn
    @IBAction func addImagBtnTapPressed(_ sender: Any) {
        self.profileTViewModel?.ChooseSourceType()
    }
    //Back Btn
    @IBAction func backTapButton() {
        self.navigationController?.popViewController(animated: true)
    }
    // MARK:- Public Methods
    class func create() -> ProfileTVC {
        let profileTVC: ProfileTVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileTVC)
            profileTVC.profileTViewModel = ProfileTViewModel(profileTVC: profileTVC)
        return profileTVC
    }
    func addImag(imageData: Data){
        let retreivedImage = UIImage(data: imageData)
        self.profileView.profileImgView?.image = retreivedImage
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //        if indexPath.row % 2 == 0{
        cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
        //        }else{
        cell.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)
        //        }
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(indexPath.row),
            options: [.curveEaseInOut],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.profileTViewModel?.confirmEdittingMsg(row: row)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.addBackground(tableView)
        if section == 0 {
            return 5
        }else if section == 1 {
            return 1
        }
        return 6
    }

private func addBackground(_ tableView: UITableView){
// Add a background view to the table view
  let backgroundImage = UIImage(named: ImagesName.backgroundImage)
let imageView = UIImageView(image: backgroundImage)
tableView.backgroundView = imageView
}
}
//MARK:- extensions
extension ProfileTVC {
    //MARK:- Handle Response of Upload user image
    private func uploadImage(_ image: UIImage){
        let imageJpegData = image.jpegData(compressionQuality: 1)!
        self.profileTViewModel?.tryUploadImage(imageJpegData)
    }
}
//MARK:- Image Picker
extension ProfileTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:- Private Methods
    private func profileViewSetUp(){
        profileView.backgroundColor = Colors.primaryColor
        profileView.separatorStyle = .singleLine
        profileView.separatorColor = Colors.placholderColor
        profileView.setup()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            self?.profileView.imageLabel.isHidden = true
            self?.profileView.profileImgView.image = profileImage
            self?.uploadImage(profileImage)
        }
    }
    
    private func imageConfiguration() {
        imagePicker.delegate = self
//        profileView.profileImgView.layer.cornerRadius = (profileView.profileImgView?.frame.size.width ?? 0.0) / 2
        profileView.profileImgView?.clipsToBounds = true
//        profileView.profileImgView?.layer.borderWidth = 3.0
//        profileView.profileImgView?.layer.borderColor = UIColor.white.cgColor
        profileView.imageLabel.isHidden = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}






