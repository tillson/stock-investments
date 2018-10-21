//
//  Stock.swift
//  Investa
//
//  Created by Nicholas Grana on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

struct Stock: Decodable, Equatable {
    
    let ticker: String
    let currentPrice: Float
    var initialPrice: Float = 0.0
    var sharesOwned = 0
    
    enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        case currentPrice = "current_price"
        case ticker
    }
    
//    let stocks: Any
    
//    var sharesOwned: Int
    
//    let history: [Date: Float]
    
    init(ticker: String, currentPrice: Float) {
        self.ticker = ticker
//        self.sharesOwned = 1
        self.currentPrice = currentPrice
//        self.history = [Date(): 4]
    }
    
    // percent success or not success
    // pull from begining of today and compare to now 
//    var percent: Int {
//        return 570
//    }
    
}


