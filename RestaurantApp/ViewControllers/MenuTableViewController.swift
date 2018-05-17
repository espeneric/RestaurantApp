//
//  MenuTableViewController.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/16/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit


class MenuTableViewController: UITableViewController {

    
    
    
    
    
    //MARK: Holding the values.
    var category: String!
    var menuItems = [MenuItem]()
    
    
    //MARK: Update UI
    
    
    func updateUI(with menuItems: [MenuItem]) {
        DispatchQueue.main.async {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: Title of the view matches the passed data in category.
        title = category.capitalized
        
        //MARK: Networking req
        MenuController.shared.fetchMenuItems(categoryName: category) { (menuItems) in
            if let menuItems = menuItems {
                self.updateUI(with: menuItems)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Configuring the table view.

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
 */
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.menuCellIdentifier, for: indexPath)
        configureCell(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    
    
    //MARK: separate function. Reusage.
    func configureCell(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        //MARK: $%.2f tells the initializer that the argument should be displayed with two digits of precision.
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
    }
 
 
    
    
    
    //MARK: MenuDetailSegue. Passing the data.
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == PropertyKeys.menuDetailSegueIdentifier { //checking the segue identifier
            let menuDetailViewController = segue.destination as! MenuItemDetailViewController //downcasting
            let index = tableView.indexPathForSelectedRow!.row //passing the data for the SELECTED index at the moment.
            menuDetailViewController.menuItem = menuItems[index] // sending this data to the menuItem object in the new view.
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
