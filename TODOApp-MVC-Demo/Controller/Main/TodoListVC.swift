//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoListVC: MainViewController {
    // MARK:- Outletss
    @IBOutlet weak var noTaskLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    
    //MARK:- Private Properties
    private var allTaskObj = [TaskData]()
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        serviceOfGetAllTask()
    }
    
    // MARK:- Actions Methods
    //Go to Profile screen
    @IBAction func goToProfileTapButton() {
        self.navigationController?.pushViewController(ProfileTVC.create(), animated: true)
    }
    
    // MARK:- Public Methods
        class func create() -> TodoListVC {
            let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
            return todoListVC
        }
    // add task Btn
    @objc func addTaskBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToAddTaskState()
    }

    

    
    // MARK:- Private Methods
private func setupView() {
    setupNavbar()
    tableViewConfiguration()
}
    private func setupNavbar() {
        let addingButton = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(addTaskBtnPressed))
        self.navigationItem.rightBarButtonItem = addingButton
    }
        private func tableViewConfiguration(){
            self.taskTableView.register(UINib(nibName: Cells.taskDataTVCell, bundle: nil), forCellReuseIdentifier: Cells.taskDataTVCell)
            self.taskTableView.dataSource = self
            self.taskTableView.delegate = self
            self.taskTableView.rowHeight = UITableView.automaticDimension
            self.taskTableView.separatorStyle = .none
            self.taskTableView.isOpaque = false
            self.noTaskLabel.isHidden = true
            self.taskTableView.reloadData()
    }
    
    //MARK:- Handle Response
    private func serviceOfGetAllTask(){
        self.view.processOnStart()
        APIManager.getAllTask() { (error, taskData) in
            if let error = error {
                print(error.localizedDescription)
                self.presentError(with: error.localizedDescription)
            } else if let taskData = taskData {
                self.allTaskObj = taskData.data
                if self.allTaskObj.count == 0 {
                   self.noTaskLabel.text = "No Data Found"
                   self.noTaskLabel.isHidden = false
                }else {
                self.noTaskLabel.isHidden = true
                self.taskTableView.reloadData()
                print("data:  \(self.allTaskObj.description)")
                print("count in data: \(self.allTaskObj.count)")
                self.taskTableView.reloadData()
                }
                self.view.processOnStop()
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.taskDataTVCell, for: indexPath) as! TaskDataTVCell
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
        return 80 //taskTableView.rowHeight
    }
}

