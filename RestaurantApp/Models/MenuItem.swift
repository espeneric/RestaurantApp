//
//  File.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/16/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation






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
    
    
    
    //MARK: We are not using init(from:) here hence the custom keys are decoded properly so there is no need for a custom decode/implementation here.
    
    
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













