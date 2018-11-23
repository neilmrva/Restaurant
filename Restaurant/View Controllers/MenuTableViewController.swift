//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Work on 10/15/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController
{
    var category:String!
    var menuItems = [MenuItem]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = category.capitalized
        MenuModelController.shared.fetchMenuItems(categoryName: category, completionHandler: onMenuItemsFetched)
    }
    
    func onMenuItemsFetched(menuItems:[MenuItem]?)
    {
        DispatchQueue.main.async
        {
            self.menuItems = menuItems!
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)

        // Configure the cell...
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        
        MenuModelController.shared.fetchImage(url: menuItem.imageURL)
        {
            (image) in
            
            if let image = image
            {
                DispatchQueue.main.async
                {
                    if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath == indexPath
                    {
                        cell.imageView?.image = image
                    }
                }
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MenuDetailSegue"
        {
            let menuDetailView = segue.destination as! MenuItemDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuDetailView.menuItem = menuItems[index]
        }
    }

}
