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
    
    class func newTransactions (dataContext: DataContext, jsonData:JSON) {
        for (_,subJson):(String, JSON) in jsonData {
//            print("index (\(index)): \(subJson)")
            newTransaction (dataContext, json: subJson)
        }
    }
    
    class func newTransaction (dataContext: DataContext, json:JSON) {
        
        let transaction = dataContext.tftransactions.firstOrCreated({$0.identifier == json["objectId"].stringValue})
            transaction.amount = json["amount"].doubleValue
            transaction.comment = json["comment"].stringValue
            transaction.date = NSDateFormatter().dateFromString(json["transactionDate"].stringValue)
            transaction.descriptionText = json["description"].stringValue
            transaction.category = nil
            transaction.currency = nil
            transaction.recipient = nil
        
        print ("Transaction identifier: \(transaction.identifier)")
        
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
