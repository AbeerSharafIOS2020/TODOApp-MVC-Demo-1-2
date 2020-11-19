        //
        //  ADDTaskVC.swift
        //  TODOApp-MVC-Demo
        //
        //  Created by AbeerSharaf on 10/31/20.
        //  Copyright © 2020 IDEAEG. All rights reserved.
        //
        
        import UIKit
        class ADDTaskVC: MainVC {
            // MARK:- Outlets
            @IBOutlet weak var mainView: UIView!
            @IBOutlet weak var screenTitle: UILabel!
            @IBOutlet weak var descriptionLabel: UILabel!
            @IBOutlet weak var descriptionTxtView: UITextView!
            //MARK:- Properties
             var addTaskPresenter: ADDTaskPresenter!
             var validator: Validator!
            // MARK:- Life Cycle Methods
            override func viewDidLoad() {
                super.viewDidLoad()
                self.addTaskPresenter = ADDTaskPresenter(validator: validator)
                self.addTaskPresenter?.onViewDidLoad(view: self)
            }
            // MARK:- Action Methods:
            @IBAction func saveBtnPressed(_ sender: Any) {
                self.addTaskPresenter?.tryAddTask(description: descriptionTxtView.text)
            }
            // MARK:- Public Methods
            class func create() -> ADDTaskVC {
                let addTaskVC: ADDTaskVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.addTaskVC)
                addTaskVC.validator = Validator(view: addTaskVC)
                return addTaskVC
            }
        }
        
