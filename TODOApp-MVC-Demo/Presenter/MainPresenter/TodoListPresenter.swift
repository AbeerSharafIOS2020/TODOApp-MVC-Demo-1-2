//
//  TodoListPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol of SignInPresenter
protocol TodoListPresenterProtocol: class {
    associatedtype View
    func onViewDidLoad(view : View)
    func serviceOfGetAllTask()
    func willDisplayCell(row: Int?)
    func tryDeleteTaskConfirm(row: Int, indexPath: IndexPath, item: TaskData)
}
//MARK:- SignUpPresenter
class TodoListPresenter: TodoListPresenterProtocol {
    //MARK:- Properties
    typealias View = MainViewProtocol
    private weak var view : MainViewProtocol?
    weak var todoListVC: TodoListVC!
    init(todoListVC: TodoListVC) {
        self.todoListVC = todoListVC
    }
    
    weak var addTaskVC: ADDTaskVC!
    init(addTaskVC: ADDTaskVC) {
        self.addTaskVC = addTaskVC
    }

    var allTaskObj = [TaskData]()
}
//MARK:- extension
extension TodoListPresenter {
    //MARK:-  Handle Response
    //get all task
     func serviceOfGetAllTask(){
        self.view?.processOnStart()
        APIManager.getAllTask { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self.allTaskObj = result.data
                print("\(self.allTaskObj)")
//                self.todoListVC.allTaskObj = result.data
                print(self.allTaskObj)
                if  result.data.count == 0 {
                    self.todoListVC.noTaskLabel.text = "No Data Found"
                    self.todoListVC.noTaskLabel.isHidden = false
                }else {
                    self.todoListVC.noTaskLabel.isHidden = true
                    self.todoListVC.taskTableView.reloadData()
                    print("data:  \(self.allTaskObj.description)")
                    print("count in data: \(self.allTaskObj.count)")
                    self.todoListVC.taskTableView.reloadData()
                }
                self.view?.processOnStop()
            }
        }
//        return self.allTaskObj
    }
    
    //Delete task
    private func callDeleteService(_ item: TaskData!){
        UserDefaultsManager.shared().taskID = item.id
        print("id in userDefult : \(UserDefaultsManager.shared().taskID ?? "")")
        self.view?.processOnStop()
        APIManager.deleteTask { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showErrorMsg(message: "del task \(error.localizedDescription)")
            case .success(let result):
                let result = result
                if result.success == true {
                    self.view?.processOnStop()
                    self.view?.showSuccessMsg(message:"Delete the task Successfully")
                }
            }
            self.view?.processOnStop()
        }
    }

    //MARK:- The confirm of the Protocol
    internal func onViewDidLoad(view : MainViewProtocol){
        self.view = view
    }
    
    func willDisplayCell(row: Int?) {
        if (row ?? 0) % 2 == 0 {
            self.todoListVC.transformPlus()
        } else {
            self.todoListVC.transformMince()
        }
        self.todoListVC.animate(row: row)
    }
    func tryDeleteTaskConfirm(row: Int,indexPath: IndexPath, item: TaskData){
        
        self.todoListVC.presentAlert(title: "Confirm", message: "Are you sure you want to Delete the task ?",
             actions: [
                 AlertableAction(title: "Cancel", style: .cancel, result: false),
                 AlertableAction(title: "Yes", style: .destructive, result: true),
             ],
             completion: { [weak self] result in
                guard result else { return }
                // handle delete (by removing the data from your array and updating the tableview)
                self?.callDeleteService(item)
                print("self.allTaskObj[indexPath.row]: \(item)")
                self?.allTaskObj.remove(at: indexPath.item)
                self?.todoListVC?.taskTableView?.deleteRows(at: [indexPath], with: .fade)
               // print("row:\(row) ")

             }
         )
     }
}
