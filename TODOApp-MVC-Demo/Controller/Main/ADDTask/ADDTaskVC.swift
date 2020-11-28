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
            @IBOutlet weak var addTaskView: ADDTaskView!
        
            //MARK:- Properties
             var addTaskViewModel: ADDTaskViewModel!
            // MARK:- Life Cycle Methods
            override func viewDidLoad() {
                super.viewDidLoad()
                addTaskView.setup()
                self.addTaskView.dataAndTimeTxtField.datePicker(target: self,
                                          doneAction: #selector(doneAction),
                                          cancelAction: #selector(cancelAction),
                                          datePickerMode: .date)

                self.addTaskViewModel = ADDTaskViewModel(addTaskVC: self)
                self.addTaskViewModel?.onViewDidLoad(view: self)
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
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:MM a"
                    let dateString = dateFormatter.string(from: datePickerView.date)
                    self.addTaskView.dataAndTimeTxtField.text = dateString
                    
                    print(datePickerView.date)
                    print(dateString)
                    
                    self.addTaskView.dataAndTimeTxtField.resignFirstResponder()
                }
            }
            @IBAction func saveBtnPressed(_ sender: Any) {
                self.addTaskViewModel?.tryAddTask(description: addTaskView.descriptionTxtField.text,  dateAndTime: addTaskView.dataAndTimeTxtField.text)
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
        
