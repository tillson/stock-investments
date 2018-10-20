//
//  Profile.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

class Profile: Codable {

    let name: String

    var fundsToTrade: Float
    var startingFunds: Float

    var ownedStocks: [Stock]
    var portfolioValue: Float
    var scoreboardPlaceGlobal: Int

    init(name: String, startingFunds: Float, portfolioValue: Float) {
        self.name = name
        self.startingFunds = startingFunds
        self.portfolioValue = portfolioValue
        self.fundsToTrade = portfolioValue // todo: change
        self.scoreboardPlaceGlobal = 1
        self.ownedStocks = [Stock(name: "Apple", symbol: "AAPL", currentPrice: 100.0, initialBuyPrice: 150.0)]
    }
    
    
}
