//
//  ADDTaskPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 11/19/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
//MARK:- Protocol
protocol ADDTaskPresenterProtocol: class {
    associatedtype View
    func onViewDidLoad(view : View)
    func tryAddTask(description: String?)
}
//MARK:- ADDTaskPresenter
class ADDTaskPresenter: ADDTaskPresenterProtocol {
    //MARK:- Properties
    typealias View = MainViewProtocol
    private weak var addTaskView : MainViewProtocol?
    weak var validator : Validator!
    init(validator: Validator) {
        self.validator = validator
    }
}
//MARK:- extension
extension ADDTaskPresenter {
    //MARK:-  Handle Response
    private func serviceSaveTask(with description: String?) {
        self.addTaskView?.processOnStart()
        //let description ="\(descriptionTxtView.text ?? "")"
        APIManager.addTask(description: description!){
            (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
                self.addTaskView?.showErrorMsg(message: error.localizedDescription)
            case .success(let result):
                self.addTaskView?.processOnStop()
                self.addTaskView?.showSuccessMsg(message: "Done saved the task successfully")
                AppDelegate.shared().switchToMainState()
                print("description: \(result.data.description )")
            }
            self.addTaskView?.processOnStop()
        }
    }
    
    //MARK:- The confirm of the Protocol
    internal func onViewDidLoad(view: MainViewProtocol) {
        self.addTaskView = view
    }
    func tryAddTask(description: String?) {
        if description?.isEmpty ?? false {
            self.addTaskView?.showErrorMsg(message: "Enter your task details..")
        } else {
            self.serviceSaveTask(with: description!)
        }
        
    }
}
