//
//  AppDelegate.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if  (UserDefaultsManager.shared().token != nil) && (UserDefaultsManager.shared().isLogin!)
        {
            switchToMainState()
        } else {
            switchToAuthState()
        }
        
        return true
    }
    //MARK:- Public Methods
    func switchToMainState() {
        let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        self.window?.rootViewController = navigationController
    }
    //----------------------------------------------------------------------------------------
    func switchToAuthState() {
        let signInVC = SignInVC.create()
        let navigationController = UINavigationController(rootViewController: signInVC)
        self.window?.rootViewController = navigationController
    }
    //----------------------------------------------------------------------------------------
    func switchToRegisterState() {
        let signUpVC = SignUpVC.create()
        let navigationController = UINavigationController(rootViewController: signUpVC)
        self.window?.rootViewController = navigationController
    }
    //----------------------------------------------------------------------------------------
    func switchToAddTaskState() {
        let addTaskVC = ADDTaskVC.create()
        let navigationController = UINavigationController(rootViewController: addTaskVC)
        self.window?.rootViewController = navigationController
    }
    //----------------------------------------------------------------------------------------
    func switchToProfileState() {
        let profileTVC = ProfileTVC.create()
        let navigationController = UINavigationController(rootViewController: profileTVC)
        self.window?.rootViewController = navigationController
    }
    //----------------------------------------------------------------------------------------
    
    
}
//MARK:- Extension
extension AppDelegate {
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
