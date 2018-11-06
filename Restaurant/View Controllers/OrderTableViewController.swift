//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Work on 10/15/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import UIKit

protocol AddToOrderDelegate
{
    func added(menuItem:MenuItem)
}

class OrderTableViewController: UITableViewController
{
    var orderedMenuItems = [MenuItem]()
    var orderMinutes = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        updateNavigationButtons()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return orderedMenuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)

        // Configure the cell...
        let menuItem = orderedMenuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            orderedMenuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            updateBadgeNumber()
            updateNavigationButtons()
        }
    }

    @IBAction func submitTapped(_ sender: Any)
    {
//        let orderTotal = orderedMenuItems.reduce(0.0)
//        {
//            (result, menuItem) -> Double in
//
//            return result + menuItem.price
//        }
        
        var orderTotal = 0.0
        for menuItem in orderedMenuItems
        {
            orderTotal += menuItem.price
        }
        
        let formattedPrice = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedPrice)", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "Submit", style: .default, handler:
                {
                    (action) in
                    self.uploadOrder()
                }
            )
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func uploadOrder()
    {
        let menuIDs = orderedMenuItems.map { $0.id }
        MenuModelController.shared.submitOrder(menuIDs: menuIDs, completionHandler: onSubmittedOrder)
    }
    
    func onSubmittedOrder(minutes:Int?)
    {
        if let minutes = minutes
        {
            DispatchQueue.main.async
            {
                self.orderMinutes = minutes
                self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
            }
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ConfirmationSegue"
        {
            let orderConfirmationViewController = segue.destination as! OrderConfirmationViewController
            orderConfirmationViewController.minutes = orderMinutes
        }
    }
    
    func updateBadgeNumber()
    {
        let orderCount = orderedMenuItems.count
        navigationController?.tabBarItem.badgeValue = orderCount > 0 ? "\(orderCount)" : nil
    }
    
    func updateNavigationButtons()
    {
        let areThereItems = orderedMenuItems.count > 0
        navigationItem.leftBarButtonItem?.isEnabled = areThereItems
        navigationItem.rightBarButtonItem?.isEnabled = areThereItems
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue)
    {
        if segue.identifier == "DismissConfirmation"
        {
            orderedMenuItems.removeAll()
            tableView.reloadData()
           
            updateBadgeNumber()
            updateNavigationButtons()
        }
    }
}

extension OrderTableViewController:AddToOrderDelegate
{
    func added(menuItem: MenuItem)
    {
        let indexPath = IndexPath(row: orderedMenuItems.count, section: 0)
        orderedMenuItems.append(menuItem)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
        updateNavigationButtons()
    }
}
