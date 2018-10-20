//
//  PortfolioStockCell.swift
//  Investa
//
//  Created by Nicholas Grana on 10/19/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class PortfolioStockCell: UICollectionViewCell {
    
    @IBOutlet var stockName: UILabel! {
        didSet {
            backgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        }
    }
    
}
