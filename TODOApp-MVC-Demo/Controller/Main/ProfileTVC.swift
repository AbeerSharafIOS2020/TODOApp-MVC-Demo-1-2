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
    
//MARK:-Properties:
    
    //MARK:-Life Cycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceOfGetProfileData()
    }
    //MARK:-Actions Methods :
    //log out Btn
    @IBAction func logoutBtnPressed(_ sender: Any) {
        confirmLogOut()
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

