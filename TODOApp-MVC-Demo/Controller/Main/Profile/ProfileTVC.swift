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
    var profileTViewModel: ProfileTViewModelProtocol!
    weak var mainVC: MainVC!
    //MARK:-Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        self.objectDelegation()
        self.profileView.setup()
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
    func sourceType(_ source: UIImagePickerController.SourceType){
        imagePicker.sourceType = source
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
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
        self.profileTViewModel.confirmEdittingMsg(row: row)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileTViewModel.numberOfRowsInSection(section)
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            self?.profileView.imageLabel.isHidden = true
            self?.profileView.profileImgView.image = profileImage
            self?.uploadImage(profileImage)
        }
    }
    private func objectDelegation(){
        imagePicker.delegate = self
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}






