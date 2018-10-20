//
//  Profile.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

class Profile: Decodable {

    let name: String

    var funds: Float
    let startingFunds = 15000.0

    let ownedStocks = [Stock(name: "Apple", symbol: "AAPL", currentPrice: 100.0, initialBuyPrice: 150.0)]
    let portfolioValue: Float = 100.0
    
    init(name: String, portfolioValue: Float) {
        self.name = name
//        self.portfolioValue = portfolioValue
        self.funds = portfolioValue
//        self.ownedStocks = [Stock(name: "Apple", symbol: "AAPL", currentPrice: 100.0, initialBuyPrice: 150.0)]
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
        } else {
            self.name = ""
        }
        if let funds = aDecoder.decodeObject(forKey: "funds") as? Float {
            self.funds = funds
        } else {
            self.funds = 0.0
        }
//        if let ownedStocks = aDecoder.decodeObject(forKey: "stocks") as? [Stock] {
//            self.ownedStocks = ownedStocks
//        } else {
//            self.ownedStocks = [Stock]()
//        }
//        if let portfolioValue = aDecoder.decodeObject(forKey: "portfolioValue") as? Float {
//            self.portfolioValue = portfolioValue
//        } else {
//            self.portfolioValue = 0.0
//        }
    }

}
