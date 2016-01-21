//
//  CoredataManager.swift
//  coredataFrmaworkCheck
//
//  Created by Vadim Trulyaev on 1/21/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

import AlecrimCoreData
import SwiftyJSON

class TFCoredataManager: NSObject {

    let dataContext = DataContext()
    
    class func newCards (dataContext: DataContext, jsonData:JSON) {
        for (_,subJson):(String, JSON) in jsonData {
            //print("index (\(index)): \(subJson)")
            newCard (dataContext, json: subJson)
        }
    }
    
    class func newCard (dataContext: DataContext, json:JSON) {
        
        let card = dataContext.tfcards.firstOrCreated({$0.identifier == json["objectId"].stringValue})
        card.name = json["name"].stringValue
        card.number = json["number"].numberValue
        card.cardholder = json["ownerName"].stringValue
        
        print ("Card identifier: \(card.identifier)")
        
        do {
            try dataContext.save()
            print ("dataContext saved successfuly")
        }
        catch let error {
            // do a nice error handling here
            print ("dataContext save error: \(error)")
        }
    }
    
    class func newTransactions (dataContext: DataContext, jsonData:JSON) {
        for (_,subJson):(String, JSON) in jsonData {
            print("index (\(index)): \(subJson)")
            newTransaction (dataContext, json: subJson)
        }
    }
    
    class func newTransaction (dataContext: DataContext, json:JSON) {
        
        let firstCard = dataContext.tfcards.first()
        
        let transaction = dataContext.tftransactions.firstOrCreated({$0.identifier == json["objectId"].stringValue})
            transaction.amount = json["amount"].doubleValue
            transaction.comment = json["comment"].stringValue
            transaction.date = NSDateFormatter().dateFromString(json["transactionDate"].stringValue)
            transaction.descriptionText = nil   //json["description"].stringValue
            transaction.card = firstCard
            transaction.category = nil
            transaction.currency = nil
            transaction.recipient = nil
        
        print ("Transaction identifier: \(transaction.identifier), amount: \(transaction.amount)")
        
        do {
            try dataContext.save()
            print ("dataContext saved successfuly")
        }
        catch let error {
            // do a nice error handling here
            print ("dataContext save error: \(error)")
        }
    }
    
}
