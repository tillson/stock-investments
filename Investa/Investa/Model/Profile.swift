//
//  Profile.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

struct Profile: Codable {

    let name: String

    var totalFunds: Float

    var ownedStocks: [Stock]
    var portfolioValue: Float
    var scoreboardPlaceGlobal: Int

}
