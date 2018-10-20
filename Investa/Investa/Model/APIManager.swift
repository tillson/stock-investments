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
    static let baseURL = ""
    
    var token: String?
    
    func register(username: String, password: String, onSuccess: @escaping(User) -> Void, onFailure: @escaping(Error) -> Void) {
        Alamofire.request(APIManager.baseURL + "/auth/register" , method: .post).responseJSON { response in
            //
        }
    }
    
    func login(username: String, password: String, onSuccess: @escaping(User) -> Void, onFailure: @escaping(Error) -> Void) {
        Alamofire.request(APIManager.baseURL + "/auth/login" , method: .post).responseJSON { response in
            //
        }
    }

    
}
