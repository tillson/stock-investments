//
//  Stock.swift
//  Investa
//
//  Created by Nicholas Grana on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

struct Stock: Codable {
    
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price 
    }
    
}
