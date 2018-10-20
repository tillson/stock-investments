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
        
        collectionView.register(UINib(nibName: "GraphHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GraphHeaderView")
        collectionView.register(UINib(nibName: "PortfolioGraphCell", bundle: nil), forCellWithReuseIdentifier: "PortfolioGraphCell")
        collectionView.register(UINib(nibName: "PortfolioStockCell", bundle: nil), forCellWithReuseIdentifier: "PortfolioStockCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // graph cell
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioGraphCell", for: indexPath) as! PortfolioGraphCell
            cell.setDataCount(20, range: 20)
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioStockCell", for: indexPath) as! PortfolioStockCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = cell.frame.height / 2
            
            return cell
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GraphHeaderView", for: indexPath) as! GraphHeaderView
        
        headerView.frame.size.height = 50
        headerView.label.text = indexPath.section == 0 ? "Revenue" : "Your Stocks"
        headerView.rightLabel.text = indexPath.section == 0 ? "$10,000" : nil 
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 0 ? CGSize(width: view.frame.width, height: view.frame.height * 0.40) : CGSize(width: view.frame.width * 0.95, height: 45)
    }
    
}
