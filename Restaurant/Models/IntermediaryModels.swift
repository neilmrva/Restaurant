//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Work on 10/15/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import Foundation

struct MenuItems:Codable
{
    let items:[MenuItem]
}

struct Categories:Codable
{
    let categories:[String]
}

struct PreparationTime:Codable
{
    let prepTime:Int
    
    enum CodingKeys:String, CodingKey
    {
        case prepTime = "preparation_time"
    }
}
