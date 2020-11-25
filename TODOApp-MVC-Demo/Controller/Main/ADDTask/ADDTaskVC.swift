        //
        //  ADDTaskVC.swift
        //  TODOApp-MVC-Demo
        //
        //  Created by AbeerSharaf on 10/31/20.
        //  Copyright © 2020 IDEAEG. All rights reserved.
        //
        
        import UIKit
        import SkyFloatingLabelTextField
        
        class ADDTaskVC: MainVC {
            // MARK:- Outlets
            @IBOutlet var addTaskView: ADDTaskView!
          
           
            //MARK:- Properties
             var addTaskPresenter: ADDTaskPresenter!
            // MARK:- Life Cycle Methods
            override func viewDidLoad() {
                super.viewDidLoad()
                self.addTaskView.dataAndTimeTxtField.datePicker(target: self,
                                          doneAction: #selector(doneAction),
                                          cancelAction: #selector(cancelAction),
                                          datePickerMode: .date)

                addTaskView.setup()
                let dateAndTime =
                self.addTaskPresenter = ADDTaskPresenter()
              self.addTaskPresenter?.onViewDidLoad(view: self)
            }
            // MARK:- Action Methods:
            @objc
            func cancelAction() {
                self.addTaskView.dataAndTimeTxtField.resignFirstResponder()
            }

            @objc
            func doneAction() {
                if let datePickerView = self.addTaskView.dataAndTimeTxtField.inputView as? UIDatePicker {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dateString = dateFormatter.string(from: datePickerView.date)
                    self.addTaskView.dataAndTimeTxtField.text = dateString
                    
                    print(datePickerView.date)
                    print(dateString)
                    
                    self.addTaskView.dataAndTimeTxtField.resignFirstResponder()
                }
            }
            @IBAction func saveBtnPressed(_ sender: Any) {
                self.addTaskPresenter?.tryAddTask(description: addTaskView.descriptionTxtField.text,  dateAndTime: addTaskView.dataAndTimeTxtField.text)
                }
            // MARK:- private Methods
          private func printTimestamp() {
             let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
                print("timestamp: \(timestamp)")
            }

            // MARK:- Public Methods
            class func create() -> ADDTaskVC {
                let addTaskVC: ADDTaskVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.addTaskVC)
                return addTaskVC
            }
        }
        
