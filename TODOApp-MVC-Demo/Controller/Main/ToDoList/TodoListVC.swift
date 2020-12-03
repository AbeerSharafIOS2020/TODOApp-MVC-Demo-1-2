//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
// 1-
protocol ToDoListNavigationDelegate: class {
    func showAuthState()
}
class TodoListVC: MainVC {
    
    // MARK:- Outletss
    @IBOutlet weak var toDoListView: ToDoListView!
    //MARK:- Private Properties
    var todoListViewModel : TodoListViewModelProtocol!
    var addTaskViewModel : ADDTaskViewModelProtocol!
    // 2-

    weak var delegate: ToDoListNavigationDelegate?
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDoListView.setup()
        self.todoListViewModel?.onViewDidLoad(view: self)
        self.todoListViewModel?.serviceOfGetAllTask()
        self.setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.toDoListView.noTaskLabel.isHidden = true
        self.todoListViewModel?.serviceOfGetAllTask()
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
        todoListVC.todoListViewModel = TodoListViewModel(todoListVC: todoListVC)
        return todoListVC
    }
    // add task Btn
    @objc func addTaskBtnPressed(_ sender: Any) {
        let vc = ADDTaskVC.create()
       // vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    // MARK:- Private Methods
    private func setupView(){
        self.setupNavbar()
        self.toDoListView.taskTableView.dataSource = self
        self.toDoListView.taskTableView.delegate = self
    }
    private func setupNavbar(){
        navigationStyle()
        let addingButton = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(addTaskBtnPressed))
        self.navigationItem.rightBarButtonItem = addingButton
    }
}
// MARK:- Table View Methods
extension TodoListVC : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoListViewModel.getAllTaskData().count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.taskDataTVCell, for: indexPath) as! TaskDataTVCell
        cell.selectionStyle = .none
        let task = self.todoListViewModel.getAllTaskData()[indexPath.row]
        cell.setupCellTaskData(object: task)
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let indexPath = indexPath
        let item = self.todoListViewModel.getAllTaskData()[indexPath.row]
        self.todoListViewModel?.tryDeleteTaskConfirm(row: row, indexPath: indexPath, item: item)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let indexPath = indexPath
        let item = self.todoListViewModel.getAllTaskData()[indexPath.row]
        self.todoListViewModel?.tryDeleteTaskConfirm(row: row, indexPath: indexPath, item: item)
        //        self.allTaskObj.remove(at: indexPath.item)
        //        self.taskTableView.deleteRows(at: [indexPath], with: .fade)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.todoListViewModel?.willDisplayCell(row: row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension TodoListVC: ToDoListNavigationDelegate {

    func showAuthState() {
    
    // 3-
    self.delegate?.showAuthState()
}
}
