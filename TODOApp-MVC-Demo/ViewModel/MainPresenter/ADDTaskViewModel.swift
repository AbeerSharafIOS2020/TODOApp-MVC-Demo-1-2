//
//  ADDTaskPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol
protocol ADDTaskViewModelProtocol {
    associatedtype View
    func onViewDidLoad(view : View)
    func tryAddTask(description: String?, dateAndTime: String?)
}
//MARK:- ADDTaskPresenter
class ADDTaskViewModel {
    //MARK:- Properties
    typealias View = MainVCProtocol
    private weak var view : MainVCProtocol?
    
    weak var addTaskVC: ADDTaskVC!
    init(addTaskVC: ADDTaskVC) {
        self.addTaskVC = addTaskVC
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
                self.view?.showSuccessMsg(message: "Done saved the task successfully")
                AppDelegate.shared().switchToMainState()
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
            self.view?.showErrorMsg(message: "Enter the date , please ..")
        }

        if description?.isEmpty ?? false {
            self.view?.showErrorMsg(message: "Enter your task details..")
        }
        else {
            self.serviceSaveTask(with: description!, dateAndTime: dateAndTime!)
        }
        
    }
}
