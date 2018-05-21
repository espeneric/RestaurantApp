//
//  CategoryTableViewController.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/16/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit


class CategoryTableViewController: UITableViewController {
    
    
    
    
    //MARK: Error handler:
    
    
    /*
     
     var errorMessageLabel: UILabel {
     let label = UILabel()
     label.text = "Apologies, something went wrong, please try again later..."
     label.textAlignment = .center
     label.numberOfLines = 0
     labe.ishidden = true
     return label
     }
     
     */

    
    func errorHelper() {
        let errorAlert = UIAlertController(title: "Error", message: "Apologies, something went wrong, please try again later...", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(errorAlert, animated: true) {
            self.networkRequest()
        }
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkRequest()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        networkRequest()
    }
    
    
     //MARK: Network request
    func networkRequest() {
        MenuController.shared.fetchCategories { (categories, error) in
            if let categories = categories {
                self.updateUI(with: categories)
            } else {
                if let _ = error {
                   self.errorHelper()
                }
            }
        }
    }
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Array for holding/passing the data.
    var categories = [String]()
    
    
    //MARK: Update the UI.
    func updateUI(with categories: [String] ) {
        
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    
    //MARK: Configuring the cells.
    
    
    
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.categoryCellIdentifier, for: indexPath)
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
        return cell
    }
    

    
    
    
    //MARK: Segue preparation.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PropertyKeys.menuSegueIdentifier {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
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
