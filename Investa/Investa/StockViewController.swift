//
//  StockViewController.swift
//  Investa
//
//  Created by Nicholas Grana on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class StockViewController: UIViewController {
    
    @IBOutlet weak var stockLineGraphView: StockLineGraphView!
    
    var stock: Stock! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stock"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        stockLineGraphView.setDataCount(20, range: 20)
        stockLineGraphView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.40)

    }
    
}
