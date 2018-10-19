//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Work on 10/15/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController
{
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var addToOrderButton:UIButton!
    
    var menuItem:MenuItem!
    var delegate:AddToOrderDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = menuItem.name
        titleLabel.text = menuItem.name
        descriptionLabel.text = menuItem.description
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        addToOrderButton.layer.cornerRadius = 5.0
        
        //Set delegate
        if let navigationController = tabBarController?.viewControllers?.last as? UINavigationController
        {
            if let orderTableViewController = navigationController.viewControllers.first as? OrderTableViewController
            {
                delegate = orderTableViewController
            }
        }
    }
    
    @IBAction func onAddToOrder()
    {
        UIView.animate(withDuration: 0.2)
        {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        delegate?.added(menuItem: menuItem)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
