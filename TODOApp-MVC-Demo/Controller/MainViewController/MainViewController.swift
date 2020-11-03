//
//  MainViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/30/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingProgress.loading.center = view.center
        view.addSubview(LoadingProgress.loading)
    }
    //MARK:- Public Methods
    // if TextField is empty
    func isEmpty(_ txtField : UITextField) -> Bool {
        if !txtField.text!.isEmpty {
            return false
         }else {
            return true
        }
    }

    // name validation
       func isValidateName(_ name: UITextField) ->Bool {
           if name.text!.count  >= 2  {
               return true
           } else {
               return false
           }
       }
    
    // password validation
    func isValidationPass(_ pass: UITextField) -> Bool {
        if pass.text!.count  >= 7  {
                      return true
                  } else {
                      return false
                  }
              }
    //age validation
    func isValidationAge(_ age: UITextField) -> Bool {
        
        if Int(age.text!)!  >= 5 {
                      return true
                  } else {
                      return false
                  }
              }

    // processOnStart
    func processOnStart() {
        view.isUserInteractionEnabled = false
        LoadingProgress.loading.startAnimating()
    }
    
    //processOnStop
    func processOnStop() {
        view.isUserInteractionEnabled = true
        LoadingProgress.loading.stopAnimating()
    }

    

}
