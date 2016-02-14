//
//  CardsTabPlaceholderViewController.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 2/14/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

class CardsTabPlaceholderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let storyboard = UIStoryboard.init(name: "Cards", bundle: nil)
        let transactions = storyboard.instantiateViewControllerWithIdentifier("CardsViewController")
        self.navigationController!.pushViewController(transactions, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
