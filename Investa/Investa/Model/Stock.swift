//
//  Stock.swift
//  Investa
//
//  Created by Nicholas Grana on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

struct Stock: Codable, Equatable {
    
    let name: String
    let symbol: String
    
    let initialBuyPrice: Float
    
    var sharesOwned: Int
    
    let history: [Date: Float]
    let currentPrice: Float
    
    init(name: String, symbol: String, currentPrice: Float, initialBuyPrice: Float) {
        self.name = name
        self.symbol = symbol
        self.currentPrice = currentPrice
        self.initialBuyPrice = initialBuyPrice
        self.sharesOwned = 1
        self.history = [Date(): 4]
    }
    
    // percent success or not success
    // pull from begining of today and compare to now 
    var percent: Int {
        return 570
    }
    
}
