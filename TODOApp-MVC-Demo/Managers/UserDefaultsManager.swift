//
//  UserDefaultsManager.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation


class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.token)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.token) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.token)!
        }
    }
    var isLogin: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLogin)
        }
        get {
            guard UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLogin) != false
                else {
                    return false
            }
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLogin)
        }
    }
    var isUploadImage: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isUploadImage)
        }
        get {
            guard UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUploadImage) != false
                else {
                    return false
            }
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUploadImage)
        }
    }
    var name: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.name)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.name) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.name)!
        }
    }
    var imagName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.imagName)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.imagName) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.imagName)!
        }
    }
    var taskID: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.taskID)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.taskID) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.taskID)!
        }
    }
    var userID: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.taskID)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.taskID) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.taskID)!
        }
    }
    
}

