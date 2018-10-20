//
//  PortfolioStockCell.swift
//  Investa
//
//  Created by Nicholas Grana on 10/19/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class PortfolioStockCell: UICollectionViewCell {
    
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var ownedStockCount: UILabel!
    
    @IBOutlet var stockName: UILabel! {
        didSet {
            backgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        }
    }
    
    var stock: Stock! {
        didSet {
            stockName.text = stock.name
            percent.text = String(stock.percent)
        }
    }
    
    var user: User! {
        didSet {
            let sameStocks = user.stocks.filter { $0 == stock }
            ownedStockCount.text = "\(sameStocks.count) stock\(sameStocks.count > 1 ? "s" : "")"
        }
    }
    
}
