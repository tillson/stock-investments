//
//  APIManager.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    static let baseURL = "http://35.229.117.21:8080"
    var sManager = Alamofire.SessionManager.default

    var user: User?
    
    var token: String? {
        didSet {
            updateTokenHeader()
        }
    }
    
    // MARK: Authentication
    func register(username: String, password: String, onSuccess: @escaping(Bool) -> Void, onFailure: @escaping(Error) -> Void) {
        if token != nil {
            return
        }
        sManager.request(APIManager.baseURL + "/auth/register",
                          method: .post,
                          parameters: ["username": username, "password": password],
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                if let error = response.error {
                    onFailure(error)
                    return
                }
                if let value = response.result.value! as? [String: String] {
                    self.token = value["access_token"]
                }
                onSuccess(true)
        }
    }
    
    func login(username: String, password: String, onSuccess: @escaping(Bool) -> Void, onFailure: @escaping(Error) -> Void) {
        if token != nil {
            return
        }
        sManager.request(APIManager.baseURL + "/auth/login",
                          method: .post,
                          parameters: ["username": username, "password": password],
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                if let error = response.error {
                    onFailure(error)
                    return
                }
                if let value = response.result.value! as? [String: String] {
                    self.token = value["access_token"]
                }
                onSuccess(true)
        }
    }
    
    // MARK: Profile
    func getCurrentUser(onSuccess: @escaping(User) -> Void, onFailure: @escaping(Error) -> Void) {
        guard let token = token else { onFailure(NoTokenError()); return; }
        sManager.request(APIManager.baseURL + "/profile/" ,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: ["Authentication": "Bearer: \(token)"])
            .responseJSON{ response in
                if let error = response.error {
                    onFailure(error)
                    return
                }
                guard let data = response.data else { onFailure(NoTokenError()); return; }
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    onSuccess(user)
                } catch let JSONError as Error {
                    print(JSONError)
                }
        }
    }

    
    // MARK: Util
    func updateTokenHeader() {
        guard let token = token else { return }
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Authorization"] = "Bearer: \(token)"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        sManager = Alamofire.SessionManager(configuration: configuration)
        print(headers)
    }

    
}

class NoTokenError: Error {
    
}
