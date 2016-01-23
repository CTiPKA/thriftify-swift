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

class TransactionsAbvancedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataContext = DataContext()
    
    var transactions = [TransactionCategorized] ()
//    var transactionsCategorizedDict = [String : [TFTransaction]] ()
    
    typealias TransactionEntry = (String, [TFTransaction])
    var transactionsCategorizedArr = [TransactionEntry] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        populateCards()
        
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
            
//            print ("date: \(transaction.date)")
            
            if let amount = transaction.amount {
                transactionCell.amountLabel?.text = amount.stringValue
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Transaction", forIndexPath: indexPath)
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if self.transactionsCategorizedArr[section].1.count > 0 {
//            print ("month: \(self.transactionsCategorizedArr[section].0)")
            return self.transactionsCategorizedArr[section].0
        } else {
            print ("self.transactions is empty")
            return "!empty month"
        }
    }
    
    
    // MARK: Table view delegate
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

}
