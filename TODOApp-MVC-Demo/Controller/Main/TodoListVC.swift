//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoListVC: MainViewController {
    // MARK:- OutLites
    @IBOutlet weak var noTaskLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    
    //MARK:- Properties
    let cellIdentifier = "TaskDataTVCell"
    var allTaskObj = [TaskData]()
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfiguration()
        serviceOfGetAllTask()
    }
    // MARK:- Actions Methods
    //Go to Profile screen
    @IBAction func goToProfileTapButton() {
        self.navigationController?.pushViewController(ProfileTVC.create(), animated: true)
    }
    
    // add task Btn
    @IBAction func addTaskBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToAddTaskState()
    }
    
    // MARK:- Private Methods
    func tableViewConfiguration(){
        taskTableView.register(UINib(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        taskTableView.dataSource = self
        taskTableView.delegate = self
        taskTableView.rowHeight = UITableView.automaticDimension
        taskTableView.separatorStyle = .none
        noTaskLabel.isHidden = true
        taskTableView.reloadData()
    }
    
    //MARK:- Handle Response
    func serviceOfGetAllTask(){
        processOnStart()
        APIManager.getAllTask() { (error, taskData) in
            if let error = error {
                self.processOnStop()
                print(error.localizedDescription)
                self.showAlert(message: "\(error.localizedDescription)", title: "Error")
            }
            else if let taskData = taskData {
                self.allTaskObj = taskData.data
                if self.allTaskObj.count == 0 {
                   self.noTaskLabel.text = "No Data Found"
                   self.noTaskLabel.isHidden = false
                   self.processOnStop()
                }else {
                self.noTaskLabel.isHidden = true
                self.taskTableView.reloadData()
                print("data:  \(self.allTaskObj.description)")
                print("count in data: \(self.allTaskObj.count)")
                self.taskTableView.reloadData()
                self.processOnStop()
                }
            }
        }
    }
    
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        return todoListVC
    }
}
// MARK:- Table View Methods

extension TodoListVC : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count in cell : \(allTaskObj.count)")
        return allTaskObj.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TaskDataTVCell
        cell.selectionStyle = .none
        let task = allTaskObj[indexPath.row]
        cell.setupCellTaskData(object: task)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return taskTableView.rowHeight
    }
}

