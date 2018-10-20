//
//  Transaction.swift
//  Investa
//
//  Created by Tillson Galloway on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import Foundation

struct Transaction {
    
    let stock: Stock
    let buyPrice: Float
    let date: Date
    let type: TransactionType
    let shares: Int
    
    init(stock: Stock, buyPrice: Float, date: Date, type: TransactionType, shares: Int) {
        self.stock = stock
        self.buyPrice = buyPrice
        self.date = date
        self.type = type
        self.shares = shares
    }
    
}


enum TransactionType {
    case buy, sell
}
