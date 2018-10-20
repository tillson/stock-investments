//
//  User.swift
//  Investa
//
//  Created by Nicholas Grana on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

struct User: Codable {
    var name: String
    var totalFunds: Int
    var percentIncrease: Float
    
    var stocks = [Stock]()
    
    // calculated score for leaderboards
    var score: Int {
        return 10
    }
    
    init(name: String, totalFunds: Int, percentIncrease: Float) {
        self.name = name
        self.totalFunds = totalFunds
        self.percentIncrease = percentIncrease
    }
    
    
}
