//
//  SearchStockTableViewController.swift
//  Investa
//
//  Created by Cameron Bennett on 10/20/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class SearchStockTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    let allStocks = ["Stock1", "Stock2", "Stock3", "Blah"]
    
    var stock: Stock?
    
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
    
    let people = ["Bucky Roberts","Lisa Tucker", "Emma Hotpocket"]
    
    let videos = [
        "Android App Dev",
        "C++ for Begginers"
    ]
    
    var filtered = [String]()
    
    var isSearching = false
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching{
            return 1
        }else{
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return filtered.count
        }
        if section == 0{
            return people.count
        }else{
            return videos.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if isSearching {
            var personName = filtered[indexPath.row]
            cell.textLabel?.text = personName
        }else{
            tableView.backgroundColor = UIColor.green
        if indexPath.section == 0{
            var personName = people[indexPath.row]
            cell.textLabel?.text = personName
        }else{
            var videoTitle = videos[indexPath.row]
            cell.textLabel?.text = videoTitle
        }
        }
        // Configure the cell...

        return cell
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchController.searchBar.text == nil || searchController.searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            
            APIManager.shared.getStock(identifier: searchController.searchBar.text!, onSuccess: { (stock) in
                self.stock = stock
                self.filtered = [stock.ticker]
                self.tableView.reloadData()
            }) { (error) in
                print(error)
            }
            
            
        }
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//    }
    
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
