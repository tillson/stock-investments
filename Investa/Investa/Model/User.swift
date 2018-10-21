//
//  User.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//
import Foundation

class User: Profile {
    
    let username: String
    var transactions = [Transaction]()
    
    override init(name: String, portfolioValue: Float) {
        self.username = name
        super.init(name: name, portfolioValue: portfolioValue)
    }
 
//    //won't get called
    required init(from decoder: Decoder) throws {
        self.username = ""
        try super.init(from: decoder)
    }

    required init?(coder aDecoder: NSCoder) {
        if let username = aDecoder.decodeObject(forKey: "username") as? String {
            self.username = username
        } else {
            self.username = ""
        }
//        if let name = aDecoder.decodeObject(forKey: "name") as? String {
//            self.name = name
//        } else {
//            self.name = ""
//        }
        super.init(coder: aDecoder)
    }
    
}
