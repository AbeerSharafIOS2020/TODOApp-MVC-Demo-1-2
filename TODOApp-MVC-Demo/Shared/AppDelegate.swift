//
//  AppDelegate.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol AppDelegateProtocol {
    func getMainWindow() -> UIWindow?
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // launch app destination
        AppStateManager.shared().start(appDelegate: self)
//        if  (UserDefaultsManager.shared().token != nil) && (UserDefaultsManager.shared().isLogin!)
//        {
//            switchToMainState()
//        } else {
//            switchToAuthState()
//        }
//
        return true
    }
////MARK:- Public Methods
//    func switchToMainState() {
//        let todoListVC = TodoListVC.create()
//        let navigationController = UINavigationController(rootViewController: todoListVC)
//        self.window?.rootViewController = navigationController
//    }
//// switchToAuthState
//    func switchToAuthState() {
//        let signInVC = SignInVC.create()
//        let navigationController = UINavigationController(rootViewController: signInVC)
//        self.window?.rootViewController = navigationController
//    }
////switchToRegisterState
//    func switchToRegisterState() {
//        let signUpVC = SignUpVC.create()
//        let navigationController = UINavigationController(rootViewController: signUpVC)
//        self.window?.rootViewController = navigationController
//    }
////switchToAddTaskState
//    func switchToAddTaskState() {
//        let addTaskVC = ADDTaskVC.create()
//        let navigationController = UINavigationController(rootViewController: addTaskVC)
//        self.window?.rootViewController = navigationController
//    }
////switchToProfileState
//    func switchToProfileState() {
//        let profileTVC = ProfileTVC.create()
//        let navigationController = UINavigationController(rootViewController: profileTVC)
//        self.window?.rootViewController = navigationController
//    }
}
//MARK:- Extension
extension AppDelegate: AppDelegateProtocol {
    func getMainWindow() -> UIWindow? {
        return self.window
    }
}

//extension AppDelegate {
//    static func shared() -> AppDelegate {
//        return UIApplication.shared.delegate as! AppDelegate
//    }
//}
