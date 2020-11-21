//
//  UIViewController+showAlert.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/30/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Protocol
struct AlertableAction {
    var title: String
    var style: UIAlertAction.Style
    var result: Bool
}

protocol Alertable {
    func presentAlert(title: String?, message: String?, actions: [AlertableAction], completion: ((Bool) -> Void)?)
}

extension UIViewController {
    //MARK:- showAlert with action
    func presentAlert(title: String?, message: String?, actions: [AlertableAction], completion: ((Bool) -> Void)?) {
      let generator = UIImpactFeedbackGenerator(style: .medium)
      generator.impactOccurred()
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      actions.forEach { action in
          alertController.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in completion?(action.result) }))
      }
      present(alertController, animated: true, completion: nil)
    }
    //MARK:- showAlert with actionSheet
    func presentAlertWithActionSheet(title: String?, message: String?, actions: [AlertableAction], completion: ((String) -> Void)?) {
      let generator = UIImpactFeedbackGenerator(style: .medium)
      generator.impactOccurred()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
      actions.forEach { action in
        alertController.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in completion?(action.title) }))
      }
      present(alertController, animated: true, completion: nil)
    }

    //MARK:- showAlert
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
    func confirmationAlert(title: String,message: String,firstBtn : UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Yes", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func presentError(with message: String) {
           self.showAlert(message: message, title: "Sorry")
       }
       
    @objc func presentSuccess(with message: String) {
           self.showAlert(message: message, title: "Success")
       }
    @objc func presentInfoMsg(with message: String) {
           self.showAlert(message: message)
       }


}
