//
//  IntermediaryModels.swift
//  RestaurantApp
//
//  Created by Sergheev Andrian on 5/16/18.
//  Copyright © 2018 Sergheev Andrian. All rights reserved.
//

import Foundation




//MARK: Intermediary models. API returns a list of categories under the key categories. Similarly to decoding the data that contains menu items you'll need an intermediate object.

struct Categories : Codable {
    let categories: [String]
}


//MARK: Intermediary models. API returns a value, preparation_time, returned from the /order endpoint representing the amount of time until the order would be ready.

struct PreparationTime :  Codable {
    
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
        
    }
}

