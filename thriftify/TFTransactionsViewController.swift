//
//  TFTransactionsViewController.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/14/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit
import CoreData

import AlecrimCoreData

class TFTransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate,DCPathButtonDelegate {
    
    var dcPathButton:DCPathButton!

    
    @IBOutlet weak var tableView: UITableView!
    
    let dataContext = DataContext()
    
    var transactions = [TFTransaction]()
    var frc: NSFetchedResultsController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let firstTransaction = transactions.first {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "mmmm '‘' YY"
            self.title = dateFormatter.stringFromDate(firstTransaction.date!);
        } else {
            self.title = "";
        }
        
        configureDCPathButton()

//        customiseNavBar ()
        populateCards()
    }
    
    func customiseNavBar () {
//        TFAppAppearance.applyAppAppearance()
        
        self.navigationController!.navigationBar.barTintColor = UIColor.greenColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        
//        UINavigationBar.appearance().backgroundColor = TFAppAppearance.navBarColor
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: TFAppAppearance.navBarTitleColor]
    }
    
    func populateCards () {
        showSpinner()
        
        TFServerManager().getCards () {
            result in
            
            switch result {
            case .Success(let json):
                TFCoredataManager.newCards(self.dataContext, jsonData: json)
                self.populateTransactions()
            case .Failure(_):
                //error happend
                self.hideSpinner()
                break
            }
        }
    }
    
    func populateTransactions () {
        TFServerManager().getTransactions() {
            result in
            
            switch result {
            case .Success(let json):
                TFCoredataManager.newTransactions(self.dataContext, jsonData: json)
                self.setupFRC()
                self.hideSpinner()
                break
            case .Failure(_):
                //error happend
                self.hideSpinner()
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Helpers
    
    func fetchRequest() -> NSFetchRequest {
        let request = NSFetchRequest.init(entityName: TFTransaction.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        return request
    }
    
    func setupFRC() {
        let request = fetchRequest()
        
        let transactions = dataContext.tftransactions
        print("transactions count: \(transactions.count())")
        
        self.frc = NSFetchedResultsController(fetchRequest: request,
            managedObjectContext: self.dataContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        self.frc?.delegate = self
        
        fetchData()
    }
    
    func fetchData() {
        do {
            try self.frc?.performFetch()
            
            tableView.reloadData()
        } catch {
            assertionFailure("Failed to fetch: \(error)")
        }
    }
    
    private func showSpinner() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
    }
    
    private func hideSpinner() {
        self.navigationItem.rightBarButtonItem = nil
    }

    // MARK: Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.frc?.fetchedObjects?.count ?? 0
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let transaction = self.frc?.objectAtIndexPath(indexPath) as! TFTransaction
        if let transactionCell = cell as? TransactionTableViewCell {
            
            var transactionDescription = transaction.descriptionText as? String
            if transactionDescription == nil {
                transactionDescription = ""
            }
            
            var cardDescription = transaction.card?.name as? String
            if cardDescription == nil {
                cardDescription = ""
            } else {
                cardDescription = " (" + cardDescription! + ")"
            }
            
            transactionCell.recepientLabel?.text = transactionDescription! + cardDescription!
            
            if let amount = transaction.amount {
            transactionCell.amountLabel?.text = amount.stringValue
            print ("amount: \(amount)")
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Transaction", forIndexPath: indexPath)
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Transactions"
    }
    
    
    // MARK: Table view delegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // MARK: Fetched results controller delegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(
        controller: NSFetchedResultsController,
        didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
        atIndex sectionIndex: Int,
        forChangeType type: NSFetchedResultsChangeType) {
            switch type {
            case .Insert:
                tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                break
            }
    }
    
    func controller(
        controller: NSFetchedResultsController,
        didChangeObject anObject: AnyObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?) {
            switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    func configureDCPathButton() {
        
        dcPathButton = DCPathButton(centerImage: UIImage(named: "chooser-button-tab"), highlightedImage: UIImage(named: "chooser-button-tab-highlighted"))
        
        dcPathButton.delegate = self
        dcPathButton.dcButtonCenter = CGPointMake(self.view.bounds.width/2, self.view.bounds.height - 80)
        dcPathButton.allowSounds = true
        dcPathButton.allowCenterButtonRotation = true
        dcPathButton.bloomRadius = 80
        dcPathButton.bloomAngel = 150
        
        let itemButton_1 = DCPathItemButton(image: UIImage(named: "chooser-moment-icon-music"), highlightedImage: UIImage(named: "chooser-moment-icon-music-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        let itemButton_2 = DCPathItemButton(image: UIImage(named: "chooser-moment-icon-place"), highlightedImage: UIImage(named: "chooser-moment-icon-place-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        let itemButton_3 = DCPathItemButton(image: UIImage(named: "chooser-moment-icon-camera"), highlightedImage: UIImage(named: "chooser-moment-icon-camera-highlighted"), backgroundImage: UIImage(named: "chooser-moment-button"), backgroundHighlightedImage: UIImage(named: "chooser-moment-button-highlighted"))
        
        dcPathButton.addPathItems([itemButton_1, itemButton_2, itemButton_3])
        
        self.view.insertSubview(dcPathButton, aboveSubview: tableView)
        
    }
    
    // DCPathButton Delegate
    //
    func pathButton(dcPathButton: DCPathButton!, clickItemButtonAtIndex itemButtonIndex: UInt) {
        
        let alertView = UIAlertView(title: "", message: "You tap at index \(itemButtonIndex)", delegate: nil, cancelButtonTitle: "Ok")
        
        alertView.show()
        
    }

}

