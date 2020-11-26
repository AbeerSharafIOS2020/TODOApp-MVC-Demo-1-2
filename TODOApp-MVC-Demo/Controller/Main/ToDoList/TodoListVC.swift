//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
class TodoListVC: MainVC {
    // MARK:- Outletss
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var noTaskLabel: UILabel!
    
    //MARK:- Private Properties
    var todoListPresenter: TodoListPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.primaryColor
        self.todoListPresenter?.onViewDidLoad(view: self)
        self.todoListPresenter?.serviceOfGetAllTask()
        self.setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.todoListPresenter?.serviceOfGetAllTask()
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
        self.taskTableView.isOpaque = false
        self.noTaskLabel.isHidden = true
        self.taskTableView.reloadData()
    }
    private func addBackground(_ tableView: UITableView){
    // Add a background view to the table view
      let backgroundImage = UIImage(named: ImagesName.backgroundImage)
    let imageView = UIImageView(image: backgroundImage)
    tableView.backgroundView = imageView
    }

}
// MARK:- Table View Methods
extension TodoListVC : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.addBackground(tableView)
        let count = self.todoListPresenter.allTaskObj.count
        print("count in cell : \(self.todoListPresenter.allTaskObj.count)")
        return count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.taskDataTVCell, for: indexPath) as! TaskDataTVCell
        cell.selectionStyle = .none
        let task = self.todoListPresenter.allTaskObj[indexPath.row]
        cell.setupCellTaskData(object: task)
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let indexPath = indexPath
//        self.allTaskObj = self.todoListPresenter.allTaskObj
        let item = self.todoListPresenter.allTaskObj[indexPath.row]
        self.todoListPresenter?.tryDeleteTaskConfirm(row: row, indexPath: indexPath, item: item)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let indexPath = indexPath
//        self.allTaskObj = self.todoListPresenter.allTaskObj
        let item = self.todoListPresenter.allTaskObj[indexPath.row]
        self.todoListPresenter?.tryDeleteTaskConfirm(row: row, indexPath: indexPath, item: item)
//        self.allTaskObj.remove(at: indexPath.item)
//        self.taskTableView.deleteRows(at: [indexPath], with: .fade)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        self.todoListPresenter?.willDisplayCell(row: row)
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
        return 100
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
