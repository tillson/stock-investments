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
            if token != nil {
                updateTokenHeader()
            }
        }
    }
    
    // MARK: Authentication
    func register(username: String, password: String, name: String, onSuccess: @escaping(Bool) -> Void, onFailure: @escaping(Error) -> Void) {
        if token != nil {
            return
        }
        sManager.request(APIManager.baseURL + "/auth/register",
                          method: .post,
                          parameters: ["username": username, "password": password, "name": name],
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

                onSuccess(true)
        }
    }
    
    // MARK: Profile
    func getCurrentUser(onSuccess: @escaping(User) -> Void, onFailure: @escaping(Error) -> Void) {
        guard let token = token else { onFailure(InvestaError.NoToken); return; }
        sManager.request(APIManager.baseURL + "/profile/" ,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: ["Authentication": "Bearer: \(token)"])
            .responseJSON{ response in
                print(response)
                if let error = response.error {
                    print("ERROR: \(error)")
                    onFailure(error)
                    APIManager.shared.token = nil
                    return
                }
                guard let data = response.data else { onFailure(InvestaError.NoToken); return; }
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    onSuccess(user)
                } catch let JSONError as Error {
                    print("Error gettig user: \(JSONError)")
                    APIManager.shared.token = nil
                }
        }
    }

    // MARK: Stocks
    func getStock(identifier: String, onSuccess: @escaping(Stock) -> Void, onFailure: @escaping(Error) -> Void) {
        guard let token = token else { onFailure(InvestaError.NoToken); return; }
        sManager.request(APIManager.baseURL + "/stocks/" ,
                         method: .post,
                         parameters: ["identifier": identifier],
                         encoding: JSONEncoding.default,
                         headers: ["Authentication": "Bearer: \(token)"])
            .responseJSON{ response in
                if let error = response.error {
                    onFailure(error)
                    return
                }
                guard let data = response.data else { onFailure(InvestaError.NoToken); return; }
                do {
                    let stock = try JSONDecoder().decode(Stock.self, from: data)
                    onSuccess(stock)
                } catch let JSONError as Error {
                    print("Error gettig stock (\(identifier)): \(JSONError)")
                }
        }
    }
    
    func buyStock(identifier: String, shares: Int, onSuccess: @escaping(Transaction) -> Void, onFailure: @escaping(Error) -> Void) {
        guard let token = token else { onFailure(InvestaError.NoToken); return; }
        sManager.request(APIManager.baseURL + "/stocks/buy" ,
                         method: .post,
                         parameters: ["identifier": identifier, "shares": shares],
                         encoding: JSONEncoding.default,
                         headers: ["Authentication": "Bearer: \(token)"])
            .responseJSON{ response in
                if let error = response.error {
                    onFailure(error)
                    return
                }
                guard let data = response.data else { onFailure(InvestaError.NoToken); return; }
                do {
                    let transaction = try JSONDecoder().decode(Transaction.self, from: data)
                    onSuccess(transaction)
                } catch let JSONError as Error {
                    print("Error gettig stock (\(identifier)): \(JSONError)")
                }
        }
    }

    func sellStock(identifier: String, shares: Int, onSuccess: @escaping(Transaction) -> Void, onFailure: @escaping(Error) -> Void) {
        guard let token = token else { onFailure(InvestaError.NoToken); return; }
        sManager.request(APIManager.baseURL + "/stocks/sell" ,
                         method: .post,
                         parameters: ["identifier": identifier, "shares": shares],
                         encoding: JSONEncoding.default,
                         headers: ["Authentication": "Bearer: \(token)"])
            .responseJSON{ response in
                if let error = response.error {
                    onFailure(error)
                    return
                }
                guard let data = response.data else { onFailure(InvestaError.NoToken); return; }
                do {
                    let transaction = try JSONDecoder().decode(Transaction.self, from: data)
                    onSuccess(transaction)
                } catch let JSONError as Error {
                    print("Error gettig stock (\(identifier)): \(JSONError)")
                }
        }
    }

    
    // MARK: Transactions
    func getUserTransactions(onSuccess: @escaping([Transaction]) -> Void, onFailure: @escaping(Error) -> Void) {
        guard let token = token else { onFailure(InvestaError.NoToken); return; }
        sManager.request(APIManager.baseURL + "/stocks/transactions" ,
                         method: .post,
                         encoding: JSONEncoding.default,
                         headers: ["Authentication": "Bearer: \(token)"])
            .responseJSON{ response in
                if let error = response.error {
                    onFailure(error)
                    return
                }
                guard let data = response.data else { onFailure(InvestaError.NoToken); return; }
                do {
                    let transactions = try JSONDecoder().decode([Transaction].self, from: data)
                    onSuccess(transactions)
                } catch let JSONError as Error {
                    print("Error gettig transactions: \(JSONError)")
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
    }

    
}

enum InvestaError: Error {
    case NoToken
}
