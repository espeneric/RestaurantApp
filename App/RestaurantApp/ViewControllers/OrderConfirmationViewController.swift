//
//  OrderConfirmationViewController.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/18/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import UIKit
import UserNotifications

class OrderConfirmationViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timeRemainingLabel.text = "Thanks for your order! Your waiting time is approximately \(minutes!) minutes."
        UNUserNotificationCenter.current().delegate = self
        notification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    var minutes: Int!
    
    
    
    
    
    
    
    
    
    //MARK: Outlets
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    

    //MARK: Local notifications. Please note that if you need to see the notifications while in app you will need to use the delegate pattern.
    
    var timeRemaining: Double {
        return (Double(minutes) - 10) * 60 //Format to seconds for the trigger.
    }
    
    var currentTime = Double(Date().minute) * 60 //Format to seconds for the trigger.
    
    
    func notification () {
        
        let center = UNUserNotificationCenter.current()
        
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Order", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Your order will be done in about 10 minutes!", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false) // Actually we should use self.currentTime + self.timeRemaining
        let identifier = "LocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        

        center.getNotificationSettings { (settings) in
            
            if settings.authorizationStatus == .authorized {
                
                center.add(request, withCompletionHandler: { (error) in
                    print("\(String(describing: error)) - this is the error!")
                })
                
            } else {
                print("No permission for local notifications.")
            }
        }
    }
    
    
    
    
    //MARK: For future reference.
    /*
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
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
