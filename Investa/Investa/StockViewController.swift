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
    
    @IBAction func clickSell(_ sender: StockOptionButton) {
        let alert = UIAlertController(title: "Sell Up to \(stock.sharesOwned) stock\(stock.sharesOwned > 1 ? "s" : "")", message: "Either sell all stocks or enter amount.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Choose Amount", style: .default, handler: { (action) in
            let alert = UIAlertController(title: "Enter amount of stocks to sell", message: "", preferredStyle: .alert)
            var textField: UITextField!
            alert.addTextField(configurationHandler: { (field) in
                field.keyboardType = .numberPad
                textField = field
            })
            
            alert.addAction(UIAlertAction(title: "Sell", style: .default, handler: { (action) in
                if let amountToSell = Int(textField.text ?? "") {
                    // TODO: sell amount of this stock
                    let title: String
                    if amountToSell > self.stock.sharesOwned {
                        title = "You do not have enough of this stock to sell."
                        
                    } else {
                        title = "You have sold \(amountToSell) stocks earning \((self.stock.currentPrice * Float(amountToSell)).moneyFormat)"
                    }
                    
                    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            }))
            alert.addAction(UIAlertAction(title: "Canel", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Sell All", style: .destructive, handler: { (action) in
            // TODO: sell all stocks
            let amount = APIManager.shared.user!.ownedStocks.filter { $0 == self.stock }.count
            
            let title = "You have sold \(amount) stocks earning \((self.stock.currentPrice * Float(amount)).moneyFormat)"
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clickBuy(_ sender: StockOptionButton) {
        let alert = UIAlertController(title: "Buy Stocks", message: "Enter amount to buy.", preferredStyle: .alert)
        var textField: UITextField!
        
        alert.addTextField(configurationHandler: { (field) in
            field.keyboardType = .numberPad
            textField = field
        })
        
        alert.addAction(UIAlertAction(title: "Buy", style: .default, handler: { (action) in
            if let amountToBuy = Int(textField.text ?? "") {
                // TODO: sell amount of this stock
                let title: String
                if Float(amountToBuy) * self.stock.currentPrice > APIManager.shared.user!.fundsToTrade {
                    title = "You do not have enough money to buy this many stocks."
                } else {
                    title = "You have bought \(amountToBuy) stocks for \((self.stock.currentPrice * Float(amountToBuy)).moneyFormat)"
                }
                
                let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Canel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
