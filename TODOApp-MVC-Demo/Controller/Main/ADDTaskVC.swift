//
//  ADDTaskVC.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ADDTaskVC: MainViewController {
    // MARK:- OutLites
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTxtView: UITextView!
    
    // MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTxtView.text = ""
    }
    // MARK:- Action Methods:
    @IBAction func saveBtnPressed(_ sender: Any) {
        if descriptionTxtView.text.isEmpty {
            showAlert(message: "Enter your task details..")
        } else {
          serviceSaveTask()
        }
    }
    //MARK:- Handle Response
    func serviceSaveTask() {
        processOnStart()
        let descriptionView = "\(descriptionTxtView.text ?? "")"
        APIManager.addTask(with: descriptionView, completion: {
            (error, taskData) in
            if let error = error {
                self.processOnStop()
                print(error.localizedDescription)
                self.showAlert(message: "\(error.localizedDescription)", title: "Error")
            } else if let taskData = taskData {
                self.processOnStop()
                self.showAlert(message: "Done saved the task successfully", title: "Success")
                AppDelegate.shared().switchToMainState()
                print("description: \(taskData.data.description )")
            }
        })
    }
    
        // MARK:- Public Methods
        class func create() -> ADDTaskVC {
            let addTaskVC: ADDTaskVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.addTaskVC)
            return addTaskVC
        }
    }

