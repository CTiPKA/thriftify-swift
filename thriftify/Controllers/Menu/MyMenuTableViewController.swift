//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let rowIcons = ["ic_avatar", "ic_transactions", "ic_shape"] //, "ic_settings", "ic_logout"]
    
    var userProfileItem : UIViewController?
    var transactionsItem : UIViewController?
    var accountsItem : UIViewController?
    var settingsItem : UIViewController?
    var logoutItem : UIViewController?
    
    var selectedMenuItem : Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor(red: 6.0/255.0, green: 209.0/255.0, blue: 187.0/255.0, alpha: 1)
        tableView.scrollsToTop = false
        
//        tableView.registerClass(MyMenuItemCell.self, forCellReuseIdentifier: "MyMenuItem")
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return rowIcons.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyMenuItem", forIndexPath: indexPath) as! MyMenuItemCell
        
        let itemIcon = UIImage(named:rowIcons[indexPath.row])
        cell.itemIcon.image = itemIcon
        cell.backgroundColor = UIColor.clearColor();
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 51.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Menu",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            if userProfileItem == nil {
               userProfileItem = mainStoryboard.instantiateViewControllerWithIdentifier("UserProfileTab Placeholder")
            }
            destViewController = userProfileItem!
            break
        case 1:
            if transactionsItem == nil {
                let transactionsStoryboard: UIStoryboard = UIStoryboard(name: "Transactions",bundle: nil)
                transactionsItem = transactionsStoryboard.instantiateViewControllerWithIdentifier("TransactionsAdvancedViewController")
            }
            destViewController = transactionsItem!
            break
        case 2:
            if accountsItem == nil {
                let cardsStoryboard: UIStoryboard = UIStoryboard(name: "Cards",bundle: nil)
                accountsItem = cardsStoryboard.instantiateViewControllerWithIdentifier("CardsViewController")
            }
            destViewController = accountsItem!
            break
        default:
            if settingsItem == nil {
                settingsItem = mainStoryboard.instantiateViewControllerWithIdentifier("SettingsTab Placeholder")
            }
            destViewController = settingsItem!
            break
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - User Actions
    @IBAction func pressedSettingsButton(sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Menu",bundle: nil)
        if settingsItem == nil {
            settingsItem = mainStoryboard.instantiateViewControllerWithIdentifier("SettingsTab Placeholder")
        }
        
        sideMenuController()?.setContentViewController(settingsItem!)
    }
    
    @IBAction func pressedLogoutButton(sender: UIButton) {
        //logout actions
    }
    

}
