//
//  MenuController.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/16/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation
import UIKit

class MenuController  {
    
    
    
    //MARK: shared instance of MenuController for the 3 requests.
    static let shared = MenuController()
    
    
    
    //MARK: Do not forget to update the info.plist for allowing http connections.
    let baseURL = URL(string: "http://localhost:8090")!
    
    //MARK: API requests. 1GET for categories 2GET for the itmes 1POST for communicating the results.
    //MARK: 1GET for categories.
    
    
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            
            //MARK: Parsing the data.
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
               //print("\(String(describing: response)) and \(String(describing: error))") //
            } else {
                //print("\(String(describing: response)) and \(String(describing: error))") //
                completion(nil)
            }
        }
        task.resume()
    }

    
    


    
   

    
    
    //MARK: 2GET for items.
    
    
    
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void ) {
        
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            
            //MARK: Parsing the data.
            
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                completion(menuItems.items)
               // print("\(String(describing: response)) and \(String(describing: error))") //
            } else {
              //  print("\(String(describing: response)) and \(String(describing: error))") //
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    
    

    
    //MARK: 1POST for the results. Sending JSON back to the server via POST request.
    
    
    
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void ) {
        
        
        let orderURL = baseURL.appendingPathComponent("order")
        
        
        
        //MARK: Telling the server what kind of data we are sending. - JSON
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //MARK: Store the array of menu IDs in JSON under the key menu IDS.
        //to do this we create a dictionary of type [String: Any ], a type which can be converted to our JSON by an instance of JSONEncoder
        let data: [String : Any ] = ["menuIds" : menuIds]
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
        
        
        //MARK: Sending the request.
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //MARK: Submitting the order.
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
               // print("\(String(describing: response)) and \(String(describing: error))") //
                completion(preparationTime.prepTime)
            } else {
                // print("\(String(describing: response)) and \(String(describing: error))") //
                completion(nil)
            }
            
            
            
            
        }
        task.resume()
    }
    
    
    
    //MARK: Fetch Image
    
    
    
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
                let image = UIImage(data: data  ) {
                completion(image)
              //  print("\(String(describing: response)) and \(String(describing: error))") //
            } else {
                completion(nil)
               // print("\(String(describing: response)) and \(String(describing: error))") //
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
