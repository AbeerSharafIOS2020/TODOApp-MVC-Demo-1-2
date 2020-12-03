//
//  ADDTaskPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol of ADDTaskViewModelProtocol
protocol ADDTaskViewModelProtocol {
    //associatedtype View
    func onViewDidLoad(view : MainVCProtocol)
    func tryAddTask(description: String?, dateAndTime: String?)
}
//MARK:- ADDTaskViewModel
class ADDTaskViewModel {
    //MARK:- Properties
   // typealias View = MainVCProtocol
 //   weak var delegate: AuthNavigationDelegate?
    private weak var view : MainVCProtocol?
    weak var addTaskVC: ADDTaskVC!
    init(addTaskVC: ADDTaskVC) {
        self.addTaskVC = addTaskVC
    }
    weak var toDoListVC: TodoListVC!
    init(toDoListVC: TodoListVC) {
        self.toDoListVC = toDoListVC
    }

}
//MARK:- extension
extension ADDTaskViewModel: ADDTaskViewModelProtocol {
    //MARK:-  Handle Response
    private func serviceSaveTask(with description: String?, dateAndTime: String?) {
        self.view?.processOnStart()
        APIManager.addTask(description: description!){
            (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showErrorMsg(message: error.localizedDescription)
            case .success(let result):
                self.view?.processOnStop()
                self.view?.showSuccessMsg(message: Messages.taskSavedSuccessMsg)
                AppStateManager.shared().showMainState()
               // self.toDoListVC.delegate?.showAuthState() // delegate?.showMainState()
               // AppDelegate.shared().switchToMainState()
                print("description: \(result.data.description )")
            }
            self.view?.processOnStop()
        }
    }
    //MARK:- The confirm of the Protocol
    internal func onViewDidLoad(view: MainVCProtocol) {
        self.view = view
    }
    func tryAddTask(description: String?, dateAndTime: String?) {
        if dateAndTime?.isEmpty ?? false {
            self.view?.showErrorMsg(message:  Messages.dateErrorMsg)
        }
        if description?.isEmpty ?? false {
            self.view?.showErrorMsg(message:Messages.taskErrorMsg)
        }
        else {
            self.serviceSaveTask(with: description!, dateAndTime: dateAndTime!)
        }
        
    }
}
