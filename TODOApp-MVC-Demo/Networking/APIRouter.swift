//
//  APIRouter.swift
//  TODOApp-MVC-Demo
//
//  Created by Ibrahim El-geddawy on 11/7/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case login(_ email: String, _ password: String)
    case getAllTask
    case register(_ name: String, _ email: String, _ password: String, _ age: Int)
    case addTask(_ description: String )
    case logout
    case getProfile
    case deleteTask
    case uploadImage(_ image: UIImage )
    case getUserImage
    case updateProfile(_ data: String )
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .getAllTask:
            return .get
        case .register:
            return .post
        case .addTask:
            return .post
        case .logout:
            return .post
        case .getProfile:
            return .put
        case .deleteTask:
            return .delete
        case .uploadImage:
            return .post
        case .getUserImage:
            return .get
        case .updateProfile:
            return . put
        }
    }
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [ParameterKeys.email: email, ParameterKeys.password: password]
        case .register(let email, let password, let name, let age):
            return [ParameterKeys.name: name, ParameterKeys.email: email, ParameterKeys.password: password, ParameterKeys.age: age]
        case .addTask(let description):
            return [ParameterKeys.description: description]
        case .uploadImage(let image):
            return [ParameterKeys.image: image]
        case .updateProfile(let data):
            return [ParameterKeys.edit: data]
        default:
            return nil
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return URLs.login
        case .getAllTask:
            return URLs.task
        case .register:
            return URLs.register
        case .addTask:
            return URLs.task
        case .logout:
            return URLs.logout
        case .getProfile:
            return URLs.getUserProfile
        case .deleteTask:
            return URLs.deleteTask
        case .uploadImage:
            return URLs.uploadImg
        case .getUserImage:
            return URLs.getImg
        case .updateProfile:
            return URLs.getUserProfile
        }
    }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getAllTask:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                                forHTTPHeaderField: HeaderKeys.authorization)
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
        case .login:
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
        case .register:
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
        case .addTask:
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
            urlRequest.setValue( "Bearer \(UserDefaultsManager.shared().token ?? "")",
                                 forHTTPHeaderField: HeaderKeys.authorization)
        case .logout:
            urlRequest.setValue( "Bearer \(UserDefaultsManager.shared().token ?? "")",
                                 forHTTPHeaderField: HeaderKeys.authorization)
        case .getProfile:
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
            urlRequest.setValue( "Bearer \(UserDefaultsManager.shared().token ?? "")",
                                 forHTTPHeaderField: HeaderKeys.authorization)
        case .deleteTask:
            urlRequest.setValue( "Bearer \(UserDefaultsManager.shared().token ?? "")",
                                 forHTTPHeaderField: HeaderKeys.authorization)
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
        case .uploadImage:
            urlRequest.setValue( "Bearer \(UserDefaultsManager.shared().token ?? "")",
                                 forHTTPHeaderField: HeaderKeys.authorization)
        case .updateProfile:
            urlRequest.setValue("application/json",
                                forHTTPHeaderField: HeaderKeys.contentType)
            urlRequest.setValue( "Bearer \(UserDefaultsManager.shared().token ?? "")",
                                 forHTTPHeaderField: HeaderKeys.authorization)
        default:
            break
        }
        // MARK: - HTTP Body
        let httpBody: Data? = {
            switch self {
                
            default:
                return nil
            }
        }()
        // MARK: - Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
// MARK: - extension
extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
