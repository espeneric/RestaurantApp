//
//  OrderConfirmationViewController.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/18/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timeRemainingLabel.text = "Thanks for your order! Your waiting time is approximately \(minutes!) minutes."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    var minutes: Int!
    
    
    //MARK: Outlets
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    

    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
