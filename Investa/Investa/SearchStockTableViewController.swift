//
//  SearchStockTableViewController.swift
//  Investa
//
//  Created by Cameron Bennett on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class SearchStockTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    let allStocks = [Stock(ticker: "APPL", currentPrice: 500), Stock(ticker: "TEZ", currentPrice: 500), Stock(ticker: "GOOG", currentPrice: 500)]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    let trending = [Stock(ticker: "APPL", currentPrice: 500), Stock(ticker: "TEZ", currentPrice: 500), Stock(ticker: "GOOG", currentPrice: 500)]
    
    let recommended = [Stock(ticker: "APPL", currentPrice: 500), Stock(ticker: "TEZ", currentPrice: 500), Stock(ticker: "GOOG", currentPrice: 500)]
    
    var filtered = [Stock(ticker: "APPL", currentPrice: 500), Stock(ticker: "TEZ", currentPrice: 500), Stock(ticker: "GOOG", currentPrice: 500)]
    
    var isSearching = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "SearchStockCell", bundle: nil), forCellReuseIdentifier: "SearchStockCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        if isSearching {
            return filtered.count
        }
        
        if section == 0 {
            return trending.count
        } else {
            return recommended.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchStockCell", for: indexPath)

//        if isSearching {
//            cell.stock = filtered[indexPath.row]
//        } else {
//            if indexPath.section == 0   {
//                cell.stock = trending[indexPath.row]
//            } else {
//                cell.stock = recommended[indexPath.row]
//            }
//        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? SearchStockCell {
//            let stock: Stock = cell.stock
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let viewController = storyboard.instantiateViewController(withIdentifier: "Stock") as? StockViewController {
//                viewController.stock = stock
//                navigationController?.pushViewController(viewController, animated: true)
//            }
//        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil || searchController.searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filtered = allStocks.filter { user in
                return user.ticker.lowercased().contains(searchController.searchBar.text!.lowercased())
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
