//
//  ViewController.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/14/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TFServerManager().getTransactions()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
