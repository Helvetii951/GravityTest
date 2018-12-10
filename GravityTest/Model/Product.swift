//
//  Product.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

struct Product: Codable {
    
    let id: Int
    let name: String
    let availableStock: Int
    let image: String
    let isFavorite: Bool
    let price: Int
    let city, description : String
    /*fileprivate*/ let latitude, longitude : String
    
//    var lat : Double {
//        return Double(latitude)!
//    }
//
//    var lon : Double {
//        return Double(longitude)!
//    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case availableStock = "available_stock"
        case image, isFavorite, price, city, description, latitude, longitude
    }
}

