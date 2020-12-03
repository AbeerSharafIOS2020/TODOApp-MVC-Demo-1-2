//
//  AppStateManager.swift
//  TODOApp-MVC-Demo
//
//  Created by AbeerSharaf on 12/3/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

protocol AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol)
}

class AppStateManager {
    
    // MARK:- AppState Enum
    enum AppState {
        case none
        case auth
        case main
    }
    
    // MARK:- Properties
    var appDelegate: AppDelegateProtocol!
    var mainWindow: UIWindow? {
        return self.appDelegate?.getMainWindow()
    }
    
    var state: AppState = .none {
        willSet(newState) {
            switch newState {
            case .auth:
                switchToAuthState()
            case .main:
                switchToMainState()
            default:
                return
            }
        }
    }
    
    // MARK:- Singleton
    private static let sharedInstance = AppStateManager()
    
    class func shared() -> AppStateManager {
        return AppStateManager.sharedInstance
    }
    
    
    func switchToMainState() {
        let todoListVC = TodoListVC.create()
        todoListVC.delegate = self
        let navigationController = UINavigationController(rootViewController: todoListVC)
        self.mainWindow?.rootViewController = navigationController
    }
    
    func switchToAuthState() {
        let signInVC = SignInVC.create()
        // 4-
        signInVC.delegate = self
        let navigationController = UINavigationController(rootViewController: signInVC)
        self.mainWindow?.rootViewController = navigationController
    }
}


extension AppStateManager: AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol) {
        self.appDelegate = appDelegate
    
        if UserDefaultsManager.shared().token != nil {
            self.state = .main
        } else {
            self.state = .auth
        }
    }
}

// 5-
extension AppStateManager: AuthNavigationDelegate {
    func showMainState() {
        self.state = .main
    }
}
    // 5-
    extension AppStateManager: ToDoListNavigationDelegate {
        func showAuthState() {
            self.state = .auth
        }
}
