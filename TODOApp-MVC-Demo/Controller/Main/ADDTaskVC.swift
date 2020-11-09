        //
        //  ADDTaskVC.swift
        //  TODOApp-MVC-Demo
        //
        //  Created by AbeerSharaf on 10/31/20.
        //  Copyright © 2020 IDEAEG. All rights reserved.
        //
        
        import UIKit
        
        class ADDTaskVC: MainViewController {
            // MARK:- Outlets
            @IBOutlet weak var mainView: UIView!
            @IBOutlet weak var screenTitle: UILabel!
            @IBOutlet weak var descriptionLabel: UILabel!
            @IBOutlet weak var descriptionTxtView: UITextView!
            
            // MARK:- Life Cycle Methods
            override func viewDidLoad() {
                super.viewDidLoad()
            }
            // MARK:- Action Methods:
            @IBAction func saveBtnPressed(_ sender: Any) {
                if descriptionTxtView.text.isEmpty {
                    self.presentError(with: "Enter your task details..")
                } else {
                    serviceSaveTask()
                }
            }
            //MARK:- Handle Response
            func serviceSaveTask() {
                self.view.processOnStart()
                let description = "\(descriptionTxtView.text ?? "")"
                APIManager.addTask(description: description){
                    (response) in
                    switch response {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.presentError(with: error.localizedDescription)
                    case .success(let result):
                        self.view.processOnStop()
                        self.presentSuccess(with: "Done saved the task successfully")
                        AppDelegate.shared().switchToMainState()
                        print("description: \(result.data.description )")
                    }
                    self.view.processOnStop()
                }
            }
            // MARK:- Public Methods
            class func create() -> ADDTaskVC {
                let addTaskVC: ADDTaskVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.addTaskVC)
                return addTaskVC
            }
        }
        
