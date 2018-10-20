//
//  TransactionCell.swift
//  Investa
//
//  Created by Nicholas Grana on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var shareCount: UILabel!
    @IBOutlet weak var toalGain: UILabel!
    
    var transaction: Transaction! {
        didSet {
            stockName.text = transaction.stock.name
            stockPrice.text = "\(transaction.stock.currentPrice.moneyFormat)"
            shareCount.text = "\(transaction.shares) share\(transaction.shares > 1 ? "s" : "")"
            toalGain.text = "\((transaction.stock.currentPrice * Float(transaction.shares) - transaction.buyPrice * Float(transaction.shares)).moneyFormat)"
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "MM/dd/yy"
            date.text = dateFormatterGet.string(from: transaction.date)
            
        }
    }
    
}

extension Float {
    
    var moneyFormat: String {
        return String(format: "$%.02f", self)
    }
    
}
