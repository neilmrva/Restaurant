//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Work on 10/15/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController
{
    var categories = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        MenuModelController.shared.fetchCategories(completionHandler: onCategoriesFetched)
    }
    
    func onCategoriesFetched(categories:[String]?)
    {
        DispatchQueue.main.async
        {
            self.categories = categories!
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        // Configure the cell...
        let categoryName = categories[indexPath.row]
        cell.textLabel?.text = categoryName.capitalized

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MenuSegue"
        //if segue.destination is MenuTableViewController
        {
            let menuTableViewController = segue
            .destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            
            menuTableViewController.category = categories[index]
        }
    }

}
