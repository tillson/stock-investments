//
//  APIManager.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    static let baseURL = ""
    
    var token: String?
    
    // user who is using the app, created in google login
    var currentUser: User?
    
}
