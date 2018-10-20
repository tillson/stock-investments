//
//  PortfolioViewController.swift
//  Investa
//
//  Created by Nicholas Grana on 10/19/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit
import Charts

class PortfolioViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "PortfolioGraphCell", bundle: nil), forCellWithReuseIdentifier: "PortfolioGraphCell")
        collectionView.register(UINib(nibName: "PortfolioStockCell", bundle: nil), forCellWithReuseIdentifier: "PortfolioStockCell")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 10 // TODO: should be size of history
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // graph cell
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioGraphCell", for: indexPath) as! PortfolioGraphCell
            cell.setDataCount(20, range: 20)
            return cell
            
        } else {
            
            // grab history item
            // create cell and display...
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioStockCell", for: indexPath) as! PortfolioStockCell
            
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 0 ? CGSize(width: view.frame.width, height: view.frame.height * 0.40) : CGSize(width: view.frame.width, height: 40)
    }
    
}
