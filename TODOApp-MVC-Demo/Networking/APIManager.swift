    //
    //  APIManager.swift
    //  TODOApp-MVC-Demo
    //
    //  Created by IDEAcademy on 10/27/20.
    //  Copyright © 2020 IDEAEG. All rights reserved.
    //
    
    import Foundation
    import UIKit
    import Alamofire
    
    class APIManager {
        class func login(with email: String, password: String, completion: @escaping (_ error: Error?, _ loginData: LoginResponse?) -> Void) {
            
            let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
            let params: [String: Any] = [ParameterKeys.email: email,
                                         ParameterKeys.password: password]
            
            AF.request(URLs.login, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil)
                    return
                }
                
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let loginData = try decoder.decode(LoginResponse.self, from: data)
                    completion(nil, loginData)
                } catch let error {
                    print(error)
                }
            }
        }
        // --------------------------------------------------------------------------------------------------------//
        class func register(name: String, email: String, password: String, age: Int, completion: @escaping (_ error: Error?, _ registerData: LoginResponse?) -> Void) {
            
            let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
            let params: [String: Any] = [ParameterKeys.email: email,
                                         ParameterKeys.password: password,
                                         ParameterKeys.name: name,
                                         ParameterKeys.age: age
            ]
            AF.request(URLs.register, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil)
                    return
                }
                
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let registerData = try decoder.decode(LoginResponse.self, from: data)
                    completion(nil, registerData)
                } catch let error {
                    print(error)
                }
            }
        }
        // --------------------------------------------------------------------------------------------------------//
        class func addTask(with description: String, completion: @escaping (_ error: Error?, _ addTask: AddTaskResponse?) -> Void) {
            let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                        HeaderKeys.authorization: "Bearer " + "\(UserDefaultsManager.shared().token ?? "")"]
            print("authorization: Bearer " + "\(UserDefaultsManager.shared().token ?? "")")
            let params: [String: Any] = [ParameterKeys.description: description ]
            AF.request(URLs.task, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil)
                    return
                }
                
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let taskData = try decoder.decode(AddTaskResponse.self, from: data)
                    completion(nil,taskData)
                } catch let error {
                    print(error)
                }
            }
        }
        
        class func getAllTask(completion: @escaping (_ error: Error?, _ alltaskData: ToDoResponse?) -> Void) {
            
            let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                        HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)"]
            
            print("authorization: Bearer " + "\(UserDefaultsManager.shared().token ?? "")")
            AF.request(URLs.getAllTask, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil )
                    return
                }
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let alltaskData = try decoder.decode(ToDoResponse.self, from: data)
                    completion(nil,alltaskData)
                } catch let error {
                    print(error)
                }
            }
        }
        
        class func logout(completion: @escaping (_ error: Error?, _ logout: LogOutResponse?) -> Void) {
            
            let headers: HTTPHeaders = [ HeaderKeys.authorization: "Bearer " + "\(UserDefaultsManager.shared().token ?? "")"]
            AF.request(URLs.logout, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil)
                    return
                }
                
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let logout = try decoder.decode(LogOutResponse.self, from: data)
                    completion(nil, logout)
                } catch let error {
                    print(error)
                }
            }
        }
        class func getProfile(completion: @escaping (_ error: Error?, _ profile: ProfileResponse?) -> Void) {
            
            let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                        HeaderKeys.authorization: "Bearer " + "\(UserDefaultsManager.shared().token ?? "")"]
            
            AF.request(URLs.getUserProfile, method: HTTPMethod.put, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil)
                    return
                }
                
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let profile = try decoder.decode(ProfileResponse.self, from: data)
                    completion(nil, profile)
                } catch let error {
                    print(error)
                }
            }
        }
        
        class func deleteTask(completion: @escaping (_ error: Error?, _ profile: DeleteTaskByIdResponse?) -> Void) {
            print("url: \(URLs.deleteTask)")
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                    HeaderKeys.authorization: "Bearer " + "\(UserDefaultsManager.shared().token ?? "")"]
          
            AF.request(URLs.deleteTask, method: HTTPMethod.delete, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let DeleteTask = try decoder.decode(DeleteTaskByIdResponse.self, from: data)
                completion(nil, DeleteTask)
            } catch let error {
                print(error)
            }
        }
    }
        class func updateProfile(_ data: String,completion: @escaping (_ error: Error?, _ profile: ProfileResponse?) -> Void) {
            let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                        HeaderKeys.authorization: "Bearer " + "\(UserDefaultsManager.shared().token ?? "")"]
            let params: [String: Any] = [ParameterKeys.edit : data]
            AF.request(URLs.getUserProfile, method: HTTPMethod.put, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error, nil)
                    return
                }
                
                guard let data = response.data else {
                    print("didn't get any data from API")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let profile = try decoder.decode(ProfileResponse.self, from: data)
                    completion(nil, profile)
                } catch let error {
                    print(error)
                }
            }
        }
    }
