//
//  MenuModelController.swift
//  Restaurant
//
//  Created by Work on 10/15/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import Foundation

class MenuModelController
{
    //let baseURL = URL(string: "http://localhost:8090/")
    let baseURL = URL(string: "http://192.168.0.9:8090/")!
    
    func fetchCategories(completionHandler: @escaping ([String]?) -> Void)
    {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: categoryURL)
        {
            (data, response, error) in
            
            if let data = data
            {
                let jsonDecoder = JSONDecoder()
                let categories = try? jsonDecoder.decode(Categories.self, from: data)
                completionHandler(categories?.categories)
            }
            else
            {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchMenuItems(categoryName:String, completionHandler: @escaping ([MenuItem]?) -> Void)
    {
        var menuURL = baseURL.appendingPathComponent("menu")
        
        var components = URLComponents(url: menuURL, resolvingAgainstBaseURL: true)!
        components.queryItems =
        [
            URLQueryItem(name: "category", value: categoryName)
        ]
        
        menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL)
        {
            (data, response, error) in
            
            if let data = data
            {
                let jsonDecoder = JSONDecoder()
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data)
                completionHandler(menuItems?.items)
            }
            else
            {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    func submitOrder(menuIDs:[Int], completionHandler: @escaping (Int?) -> Void)
    {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data:[String:[Int]] = ["menuIds":menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            
            if let data = data
            {
                let jsonDecoder = JSONDecoder()
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data)
                completionHandler(preparationTime?.prepTime)
            }
            else
            {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
}
