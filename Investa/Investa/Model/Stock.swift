//
//  Stock.swift
//  Investa
//
//  Created by Nicholas Grana on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

struct Stock: Codable {
    
    let name: String
    let initialBuyPrice: Double
    
    var sharesOwned: Int
    
    let history: [Date: Double]
    let currentPrice: Double
    
}
