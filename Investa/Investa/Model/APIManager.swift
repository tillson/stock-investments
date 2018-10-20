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
    static let baseURL = "http://localhost:8080"
    
    var user: User?
    
    var token: String?
    
    func register(username: String, password: String, onSuccess: @escaping(Bool) -> Void, onFailure: @escaping(Error) -> Void) {
        Alamofire.request(APIManager.baseURL + "/auth/register", method: .post, parameters: ["username": username, "password": password]).responseJSON { response in
            //
        }
    }
    
    func login(username: String, password: String, onSuccess: @escaping(Bool) -> Void, onFailure: @escaping(Error) -> Void) {
        Alamofire.request(APIManager.baseURL + "/auth/login", method: .post, parameters: ["username": username, "password": password]).responseJSON { response in
            //
        }
    }
    
    func getCurrentUser(onSuccess: @escaping(User) -> Void, onFailure: @escaping(Error) -> Void) {
        Alamofire.request(APIManager.baseURL + "/profile" , method: .post).responseJSON { response in
            //
        }
    }

    
}
