//
//  UIViewController+showAlert.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/30/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(message: String, title: String = "",okTitle: String = "OK", okHandler: ((UIAlertAction)-> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let oKAction = UIAlertAction(title: okTitle, style: .cancel, handler: okHandler)
        alert.addAction(oKAction)
        self.present(alert, animated: true, completion: nil)
    }
    func showCustomAlertWithAction(title: String,message: String,firstBtn : UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(firstBtn)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func presentError(with message: String) {
           self.showAlert(message: message, title: "Sorry")
       }
       
    @objc func presentSuccess(with message: String) {
           self.showAlert(message: message, title: "Success")
       }

}
