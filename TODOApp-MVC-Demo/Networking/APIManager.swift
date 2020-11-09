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
        //MARK:- Login
        class func  login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>)-> ()){
            request(APIRouter.login(email, password)){ (response) in
                completion(response)
            }
        }
        //MARK:- Register
        class func register(name: String, email: String, password: String, age: Int, completion: @escaping (Result<LoginResponse, Error>)-> ()){
            request(APIRouter.register(name, email, password, age)){ (response) in
                completion(response)
            }
        }
        //MARK:- AddTask
        class func addTask(description: String, completion: @escaping (Result<AddTaskResponse, Error>)-> ()){
            request(APIRouter.addTask(description)){ (response) in
                completion(response)
            }
        }
        //MARK:- Get TODOS
        class func getAllTask(completion: @escaping (Result<ToDoResponse, Error>)-> ()){
           request(APIRouter.getAllTask){ (response) in
               completion(response)
           }
        }
        //MARK:- Logout
        class func logout(completion: @escaping (Result<LogOutResponse, Error>)-> ()){
            request(APIRouter.logout){ (response) in
                completion(response)
            }
        }
        //MARK:- GetProfile
        class func getProfile(completion: @escaping (Result<ProfileResponse, Error>)-> ()){
            request(APIRouter.getProfile){ (response) in
                completion(response)
            }
        }
        //MARK:- DeleteTask
        class func deleteTask(completion: @escaping (Result<DeleteTaskByIdResponse, Error>)-> ()){
            request(APIRouter.deleteTask){ (response) in
               completion(response)
           }
        }

            //MARK:- UpdateProfile
            class func updateProfile(data: String, completion: @escaping (Result<ProfileResponse, Error>)-> ()){
                request(APIRouter.updateProfile(data)){ (response) in
                   completion(response)
               }
            }
        
        //MARK:- UploadImage
        class func uploadPhoto(with image: UIImage, completion: @escaping (Bool) -> Void) {
            guard let imageJpegData = image.jpegData(compressionQuality: 0.8),
            let token = UserDefaultsManager.shared().token else {return}
            print("token: \(token)")
            let headers: HTTPHeaders = [HeaderKeys.authorization: HeaderValues.brearerToken]
            
            AF.upload(multipartFormData: { (formData) in
                formData.append(imageJpegData, withName: "avatar", fileName: "/home/ali/Mine/c/nodejs-blog/public/img/blog-header.jpg", mimeType: "blog-header.jpg")
            }, to: URLs.uploadImage, method: HTTPMethod.post, headers: headers).response {
                response in
                guard response.error == nil else {
                    print(response.error!.localizedDescription)
                    completion(false)
                    return
                }
                print(response)
                completion(true)
            }
        }
        //MARK:- GetImage
        class func getProfilePhoto(with id: String, completion: @escaping (_ error: Error?,_ image: Data?,_ imageResponse: GetUserImageResponse?) -> Void) {
            
            AF.request(URLs.getImg, method: .get).response {
                response in
                guard response.error == nil else {
                    print(response.error!)
                    completion(response.error!, nil, nil)
                    return
                }
                
                print(response)
                
                guard let data = response.data else {
                    print("can't find any data")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let imageData = try decoder.decode(GetUserImageResponse.self, from: data)
                    completion(nil, nil, imageData)
                } catch let error {
                    print(error)
                    completion(nil, data, nil)
                }
            }
        }
    }
    extension APIManager{
        // MARK:- The request function to get results in a closure
        private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
            // Trigger the HttpRequest using AlamoFire
            AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            .responseJSON { response in
                print(response)
            }
        }
//        private static func upload<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
//            // Trigger the HttpRequest using AlamoFire
//            AF.upload(multipartFormData: { (<#MultipartFormData#>) in
//                switch response.result {
//                case .success(let value):
//                    completion(.success(value))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//            .responseJSON { response in
//                print(response)
//            }
//        }

    }
