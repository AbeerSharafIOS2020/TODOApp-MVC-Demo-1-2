//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

protocol TodoListVCProtocol: class {
//    func showErrorMsg(message: String)
//    func showSuccessMsg(message: String)
//    func processOnStart()
//    func processOnStop()
     // func transform()
    //  func transformMince()
}

class TodoListVC: MainVC {
    // MARK:- Outletss
    @IBOutlet weak var noTaskLabel: UILabel!
    @IBOutlet weak var taskTableView: UITableView!
    //MARK:- Private Properties
     var todoListPresenter: TodoListPresenter!
     var validator: Validator!
     var allTaskObj = [TaskData]()
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       self.todoListPresenter?.onViewDidLoad(view: self)
        self.allTaskObj = self.todoListPresenter?.serviceOfGetAllTask() ?? []
       self.setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
       self.allTaskObj = self.todoListPresenter?.serviceOfGetAllTask() ?? []
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK:- Actions Methods
    //Go to Profile screen
    @IBAction func goToProfileTapButton() {
self.navigationController?.pushViewController(ProfileTVC.create(), animated: true)
    }
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        todoListVC.todoListPresenter = TodoListPresenter(todoListVC: todoListVC)
        return todoListVC
    }
    // add task Btn
    @objc func addTaskBtnPressed(_ sender: Any) {
        AppDelegate.shared().switchToAddTaskState()
    }
    // MARK:- Private Methods
    private func setupView() {
        self.setupNavbar()
        self.tableViewConfiguration()
    }
    private func setupNavbar() {
        let addingButton = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(addTaskBtnPressed))
        self.navigationItem.rightBarButtonItem = addingButton
    }
    private func tableViewConfiguration(){
        self.taskTableView.register(UINib(nibName: Cells.taskDataTVCell, bundle: nil), forCellReuseIdentifier: Cells.taskDataTVCell)
        self.taskTableView.dataSource = self
        self.taskTableView.delegate = self
        self.taskTableView.separatorStyle = .none
        self.taskTableView.rowHeight = UITableView.automaticDimension
        self.taskTableView.separatorStyle = .none
        self.taskTableView.isOpaque = false
        self.noTaskLabel.isHidden = true
        self.taskTableView.reloadData()
    }
}
// MARK:- Table View Methods
extension TodoListVC : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.allTaskObj.count
        print("count in cell : \(allTaskObj.count)")
        return count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.taskDataTVCell, for: indexPath) as! TaskDataTVCell
        cell.selectionStyle = .none
        self.allTaskObj = self.todoListPresenter.allTaskObj
        let task = self.todoListPresenter.allTaskObj[indexPath.row]
        cell.setupCellTaskData(object: task)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let indexPath = indexPath
        let item = indexPath.item
        self.todoListPresenter?.tryDeleteTaskConfirm(row: row, indexPath: indexPath, item: item)

//        let alertConfirmDeleteNotifiy = UIAlertController(title:"Confirm", message: "Are you sure you want to Delete the task ? ", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "OK", style:.default)
//        { (UIAlertAction) in
//
//            // handle delete (by removing the data from your array and updating the tableview)
//            let row = indexPath.row
//        self.todoListPresenter?.callDeleteService(self.allTaskObj[row])
//            print("self.allTaskObj[indexPath.row]: \(self.allTaskObj[indexPath.row] )")
//            self.allTaskObj.remove(at: indexPath.item)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            print("row:\(row) ")
//        }
//        
//        let noAlertAction = UIAlertAction(title: "cancel", style: .cancel,handler: nil)
//        alertConfirmDeleteNotifiy.addAction(alertAction)
//        alertConfirmDeleteNotifiy.addAction(noAlertAction)
//        self.present(alertConfirmDeleteNotifiy, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let indexPath = indexPath
        let item = indexPath.item
        self.todoListPresenter?.tryDeleteTaskConfirm(row: row, indexPath: indexPath, item: item)
//        if (editingStyle == .delete) {
//
//            let alertConfirmDeleteNotifiy = UIAlertController(title:"Confirm", message: "Are you sure you want to Delete the task ? ", preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style:.default)
//            { (UIAlertAction) in
//                // handle delete (by removing the data from your array and updating the tableview)
//          self.todoListPresenter?.callDeleteService(self.allTaskObj[row])
//                print("self.allTaskObj[indexPath.row]: \(self.allTaskObj[indexPath.row] )")
//                self.allTaskObj.remove(at: indexPath.item)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                print("row:\(row) ")
//            }
//
//            let noAlertAction = UIAlertAction(title: "cancel", style: .cancel,handler: nil)
//            alertConfirmDeleteNotifiy.addAction(alertAction)
//            alertConfirmDeleteNotifiy.addAction(noAlertAction)
//            self.present(alertConfirmDeleteNotifiy, animated: true, completion: nil)
//
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.todoListPresenter?.willDisplayCell(row: row)
//        self.todoListPresenter?.willDisplayCell(row: row)
//        if indexPath.row % 2 == 0 {
//            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
//        } else {
//            cell.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)
//        }
//        UIView.animate(
//            withDuration: 0.5,
//            delay: 0.1 * Double(indexPath.row),
//            options: [.curveEaseInOut],
//            animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0)
//        })
    }
    func animate(row: Int?){
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(row!),
            options: [.curveEaseInOut],
            animations: {
                self.transform()
        })
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // to transform the cell form south
        func transformPlus(){
            func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)

            }
        }
    // to transform the cell form north
        func transformMince(){
            func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.transform = CGAffineTransform(translationX: -tableView.bounds.width, y: 0)

            }}
    // to transform the cell
        func transform(){
                func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }}

}
//MARK:- Handle Response
extension TodoListVC {
//    //get all task
//    private func serviceOfGetAllTask(){
//        self.view.processOnStart()
//        APIManager.getAllTask { (response) in
//            switch response{
//            case .failure(let error):
//                print(error.localizedDescription)
//            case .success(let result):
//                self.allTaskObj = result.data
//                if  self.allTaskObj.count == 0 {
//                    self.noTaskLabel.text = "No Data Found"
//                    self.noTaskLabel.isHidden = false
//                }else {
//                    self.noTaskLabel.isHidden = true
//                    self.taskTableView.reloadData()
//                    print("data:  \(self.allTaskObj.description)")
//                    print("count in data: \(self.allTaskObj.count)")
//                    self.taskTableView.reloadData()
//                }
//                self.view.processOnStop()
//            }
//        }
//    }
//    //Delete task
//    private func callDeleteService(_ item: TaskData){
//        UserDefaultsManager.shared().taskID = item.id
//        print("id in userDefult : \(UserDefaultsManager.shared().taskID ?? "")")
//        self.view.processOnStop()
//        APIManager.deleteTask { (response) in
//            switch response {
//            case .failure(let error):
//                print(error.localizedDescription)
//                self.presentError(with: "del task \(error.localizedDescription)")
//            case .success(let result):
//                let result = result
//                if result.success == true {
//                    self.view.processOnStop()
//                    self.presentSuccess(with: "Delete the task Successfully")
//                }
//            }
//            self.view.processOnStop()
//        }
//        self.todoListPresenter?.serviceOfGetAllTask()
//    }
    


}
