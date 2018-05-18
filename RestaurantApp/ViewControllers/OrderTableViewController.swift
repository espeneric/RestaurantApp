//
//  OrderTableViewController.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/16/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit



//MARK: Initialize the delegate.
protocol AddToOrderDelegate {
    func added(menuItem: MenuItem)
}



class OrderTableViewController: UITableViewController, AddToOrderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if menuItems.count == 0 {
            submitButton.isEnabled = false
            editButtonItem.isEnabled = false
        } else {
            submitButton.isEnabled = true
            editButtonItem.isEnabled = true
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    //MARK: Delegate
    
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        let count  = menuItems.count
        let indexPath = IndexPath(row: count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }
    
    
    
    
    //MARK: Hold the value! This one can be presented without any data so it should be a empty collection.
    
    
    var menuItems = [MenuItem]()
    
    
    
    //MARK: Configuring the table view.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.orderCellIdentifier, for: indexPath)
        configureCell(cell: cell, forItemAt: indexPath)
        return cell
    }
     
    
     
    //MARK: separate function. Reusage.
    func configureCell(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        //MARK: $%.2f tells the initializer that the argument should be displayed with two digits of precision.
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            
            //MARK: Since in tableview cells are re-used we need to check the current indexpath!!
            
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                    currentIndexPath != indexPath {  //MARK: if the indexpath is changed, skip setting the image.
                    return
                }
                cell.imageView?.image = image
            }
        }
        
    }
    
    
    
    //MARK: Updating the badge value based on the current amount of orders.
    func updateBadgeNumber() {
        let badgeValue = menuItems.count > 0 ? "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    
    
    //MARK: Implementation for removing the item from the order.
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            menuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
        }
    }
    
    

    //MARK: Submit outlet.
    
    
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    
    //MARK: Presenting an alert with the totals for the order.
    @IBAction func submitTapped(_ sender: Any) {
        
        
        
        //MARK: Explanation of the closure. 0.0 - initial value, result and menuItem being the x and y of the array.
        //The closure function returns the total price from the given array.
        let orderTotal = menuItems.reduce(0.0) { (result, menuItem) -> Double in
            return result + menuItem.price
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (action) in
            self.uploadOrder()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: Uploading the order.
    
    
    //MARK: Storing the data:
    var orderMinutes: Int!
    
    func uploadOrder() {
        
        
        let menuIds = menuItems.map{ $0.id }
        
        MenuController.shared.submitOrder(menuIds: menuIds) { (minutes) in
            
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier: PropertyKeys.confirmationSegue, sender: nil)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.confirmationSegue {
            let orderConfirmationViewController = segue.destination as! OrderConfirmationViewController
            orderConfirmationViewController.minutes = orderMinutes
        }
    }
    
    
    
    
    
    
    
    
    
    //MARK: Updating the table view after dismissal.
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        
        if segue.identifier == PropertyKeys.dismissConfirmation {
            menuItems.removeAll()
            tableView.reloadData()
            updateBadgeNumber()
        }
        
    }
    
    
    
    
    //MARK: Adjust the height of the rows.
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    
    
    
    

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
