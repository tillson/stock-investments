//
//  SearchStockTableViewController.swift
//  Investa
//
//  Created by Cameron Bennett on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class SearchStockTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    let allStocks = [Stock(name: "Apple", symbol: "APPL", currentPrice: 1000, initialBuyPrice: 0), Stock(name: "Tesla", symbol: "TEZLA", currentPrice: 420, initialBuyPrice: 0), Stock(name: "Google", symbol: "GOOG", currentPrice: 200, initialBuyPrice: 10)]
    
    let searchController = UISearchController(searchResultsController: nil)
    override func viewWillAppear(_ animated: Bool) {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    let trending = [Stock(name: "Apple", symbol: "APPL", currentPrice: 1000, initialBuyPrice: 0), Stock(name: "Tesla", symbol: "TEZLA", currentPrice: 420, initialBuyPrice: 0), Stock(name: "Google", symbol: "GOOG", currentPrice: 200, initialBuyPrice: 10)]
    
    let recommended = [Stock(name: "Apple", symbol: "APPL", currentPrice: 1000, initialBuyPrice: 0), Stock(name: "Tesla", symbol: "TEZLA", currentPrice: 420, initialBuyPrice: 0), Stock(name: "Google", symbol: "GOOG", currentPrice: 200, initialBuyPrice: 10)]
    
    var filtered = [Stock(name: "Apple", symbol: "APPL", currentPrice: 1000, initialBuyPrice: 0), Stock(name: "Tesla", symbol: "TEZLA", currentPrice: 420, initialBuyPrice: 0), Stock(name: "Google", symbol: "GOOG", currentPrice: 200, initialBuyPrice: 10)]
    
    var isSearching = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "SearchStockCell", bundle: nil), forCellReuseIdentifier: "SearchStockCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return 1
        } else {
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return filtered.count
        }
        
        if section == 0 {
            return trending.count
        } else {
            return recommended.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchStockCell", for: indexPath) as! SearchStockCell

        if isSearching {
            cell.stock = filtered[indexPath.row]
        } else {
            if indexPath.section == 0   {
                cell.stock = trending[indexPath.row]
            } else {
                cell.stock = recommended[indexPath.row]
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchStockCell {
            let stock: Stock = cell.stock

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "Stock") as? StockViewController {
                viewController.stock = stock
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil || searchController.searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filtered = allStocks.filter { user in
                return user.name.lowercased().contains(searchController.searchBar.text!.lowercased())
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching{
            return "Search Results"
        }
        if section == 0{
            return "Hot Stocks"
        }else{
            return "Recommended"
        }
    }

}
