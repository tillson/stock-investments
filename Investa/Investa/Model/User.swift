//
//  User.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

class User: Profile {
    
    let email: String
    
    init(name: String, email: String, startingFunds: Float, portfolioValue: Float) {
        self.email = email
        super.init(name: name, startingFunds: startingFunds, portfolioValue: portfolioValue)
    }
    
    required init(from decoder: Decoder) throws {
        self.email = "asdf@gmail.com"
        try super.init(from: decoder)
    }
}
