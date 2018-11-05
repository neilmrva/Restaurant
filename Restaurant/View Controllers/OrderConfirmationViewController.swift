//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Work on 11/5/18.
//  Copyright © 2018 neilmrva. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController
{
    @IBOutlet weak var timeRemainingLabel:UILabel!
    var minutes:Int!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue)
    {
        
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
