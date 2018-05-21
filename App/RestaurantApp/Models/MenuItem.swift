//
//  File.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/16/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation
import UIKit




struct MenuItem : Codable {
    
    
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
    
    init(id: Int, name: String, description: String, price: Double, category: String, imageURL: URL) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.imageURL = imageURL
    }
    
    
    
    
    
    
}


//MARK: Additional layer since the JSON API sends an array of items to us:
/*
 {
 "items" : [
 
 ]
 }
 */


struct MenuItems: Codable {
    let items: [MenuItem]
}





extension MenuItem {
    
    //MARK: Saving data to the disk.
     static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
     static let archiveURL = documentsDirectory.appendingPathComponent("menu").appendingPathExtension("plist")
 
 
    
    static func saveToFile(order: [MenuItem]) {
        
        let propertyListEncoder = PropertyListEncoder()
        let encodedOrder = try? propertyListEncoder.encode(order)
        try? encodedOrder?.write(to: MenuItem.archiveURL, options: .noFileProtection)
    }
    
    
    static func loadFromFile() -> [MenuItem]? {
        
        guard let codedOrders = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Array<MenuItem>.self, from: codedOrders)
    }

    
}











