//
//  TransactionsAbvancedViewController.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/22/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit
import CoreData

import AlecrimCoreData

struct TransactionCategorized {
    let month: String
    let transaction: TFTransaction
}

class TransactionsAdvancedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DCPathButtonDelegate {
    
    var dcPathButton:DCPathButton!
    @IBOutlet weak var tableView: UITableView!
    
    let dataContext = DataContext()
    var transactions = [TransactionCategorized] ()
//    var transactionsCategorizedDict = [String : [TFTransaction]] ()
    
    typealias TransactionEntry = (month:String, transactions:[TFTransaction])
    var transactionsCategorizedArr = [TransactionEntry] ()
    
    let formatterWithSepator: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.groupingSeparator = ","
        formatter.currencyCode = " €"
        formatter.numberStyle = .DecimalStyle
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.hidesBackButton = true
        
        populateCards()
        updateTitle()
        configureDCPathButton()
        
//        customiseNavBar()
    }
    
    func updateTitle () {
        if let firstTransactionCategory = transactionsCategorizedArr.first {

            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMMM '‘' yy"
            if let transaction = firstTransactionCategory.1.first {
                if let date = transaction.date {
                    self.title = dateFormatter.stringFromDate(date);
                } else {
                    self.title = ""
                }
            }
        } else {
            self.title = "";
        }
    }
    
    func customiseNavBar () {
//        TFAppAppearance.applyAppAppearance()
        
//        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
//        self.navigationController!.navigationBar.barTintColor = TFAppAppearance.navBarColor
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: TFAppAppearance.navBarTitleColor]
        
//        UINavigationBar.appearance().barStyle = UIBarStyle.Black
//        UINavigationBar.appearance().barTintColor = TFAppAppearance.navBarColor
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: TFAppAppearance.navBarTitleColor]
        
//        self.navigationController?.navigationBar.translucent = false
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
                self.setupTableView()
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
    func setupTableView() {
        transactionsCategorizedArr = buildTransactionIndex(dataContext.tftransactions.orderByAscending({ $0.date }).map({ $0 }))
        
        print("transactions categories count: \(transactionsCategorizedArr.count)")
        
        tableView.reloadData()
        updateTitle()
    }
    
    func distinct<T: Equatable>(source: [T]) -> [T] {
        var unique = [T]()
        for item in source {
            if !unique.contains(item) {
                unique.append(item)
            }
        }
        return unique
    }
    
    func buildTransactionIndex(transactions: [TFTransaction]) -> [TransactionEntry] {
        return distinct(transactions.map({ $0.month }))
            .map {
                (month) -> TransactionEntry in
                return (month, transactions.filter {
                    (transaction) -> Bool in
                    transaction.month == month
                    })
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
        return transactionsCategorizedArr.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsCategorizedArr[section].1.count ?? 0
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let transaction = self.transactionsCategorizedArr[indexPath.section].1[indexPath.row]
        if let transactionCell = cell as? TransactionTableViewCell {

            var commentDescription = transaction.comment as? String
            if commentDescription == nil {
                commentDescription = ""
            }
            
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
            
            transactionCell.titleLabel?.text = commentDescription
            transactionCell.detailTextLabel?.text = transactionDescription
            
//            print ("date: \(transaction.date)")
            
            if let amount = transaction.amount {
                transactionCell.amountLabel?.text = formatterWithSepator.stringFromNumber(amount)
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Transaction", forIndexPath: indexPath)
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        if self.transactionsCategorizedArr[section].1.count > 0 {
////            print ("month: \(self.transactionsCategorizedArr[section].0)")
//            return self.transactionsCategorizedArr[section].0
//        } else {
//            print ("self.transactions is empty")
//            return "!empty month"
//        }
//    }
    
    func configureSection(cell: UITableViewCell, atSection section: Int) {
        let transactionEntry = self.transactionsCategorizedArr[section]
        if let transactionCell = cell as? MonthCategoryCell {
            transactionCell.monthTitle?.text = transactionEntry.month
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("Month Category")
        configureSection(cell!, atSection: section)
        return cell
    }

    
    
    
    // MARK: Table view delegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func configureDCPathButton() {
        
//        dcPathButton = DCPathButton(centerImage: UIImage(named: "chooser-button-tab"), highlightedImage: UIImage(named: "chooser-button-tab-highlighted"))
        dcPathButton = DCPathButton(centerImage: UIImage(named: "bottomMenuButtonBackground"), highlightedImage: UIImage(named: "bottomMenuButtonHihglightedBackground"))
        
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