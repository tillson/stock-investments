//
//  ScoreboardTableViewController.swift
//  Investa
//
//  Created by Cameron Bennett on 10/19/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit

class ScoreboardTableViewController: UITableViewController {

    var leaderboard: [Profile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToLeaderboard()
        tableView.delegate = self
        tableView.dataSource = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func addToLeaderboard(){
        let guy1 = Profile(name: "Person 1", startingFunds: 100.0, portfolioValue: 150.0)
        leaderboard.append(guy1)
        let guy2 = Profile(name: "Person 2", startingFunds: 100.0, portfolioValue: 200.0)
        leaderboard.append(guy2)
        let guy3 = Profile(name: "Person 3", startingFunds: 100.0, portfolioValue: 250.0)
        leaderboard.append(guy3)
        let guy4 = Profile(name: "Person 4", startingFunds: 100.0, portfolioValue: 300.0)
        leaderboard.append(guy4)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaderboard.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = leaderboard[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        cell.pic.image = UIImage(named: "sample")
        cell.name.text = user.name
        cell.totalFunds.text = "\(user.portfolioValue)"
        cell.percentChange.text = "\(user.portfolioValue / user.startingFunds * 100)"
        cell.pic.layer.cornerRadius = 41
        cell.pic.layer.masksToBounds = true
        cell.pic.clipsToBounds = true
        return cell
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