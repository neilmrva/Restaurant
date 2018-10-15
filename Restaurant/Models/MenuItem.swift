//
//  MenuItem.swift
//  Restaurant
//
//  Created by Work on 10/15/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import Foundation

struct MenuItem:Codable
{
//    "id": 1,
//    "name": "Spaghetti and Meatballs",
//    "description": "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.",
//    "price": 9.0,
//    "category": "entrees",
//    "imageName": ""
    
    var id:Int
    var name:String
    var description:String
    var price:Double
    var category:String
    var imageURL:URL
    
    enum CodingKeys:String, CodingKey
    {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}
