//
//  TFTransaction.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/15/16.
//  Copyright © 2016 vt. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class TFTransaction: NSManagedObject {
    
    static let entityName = "TFTransaction"
    
    init(context: NSManagedObjectContext,
        id: NSNumber,
        amount: NSNumber,
        comment: String,
        date: NSDate?,
        descriptionText: String,
        category: TFCategory? = nil,
        currency: TFCurrency? = nil,
        recipient: TFRecipient? = nil)
    {
        let entity = NSEntityDescription.entityForName(TFTransaction.entityName, inManagedObjectContext: context)!
        super.init(entity:entity, insertIntoManagedObjectContext: context)
        
        self.id = id
        self.amount = amount
        self.comment = comment
        self.date = date
        self.descriptionText = descriptionText
        self.category = category
        self.currency = currency
        self.recipient = recipient
        
    }
    
    class func newTransactions (context:NSManagedObjectContext, jsonData:JSON) {
        for (index,subJson):(String, JSON) in jsonData {
            print("index (\(index)): \(subJson)")
            TFTransaction.newTransaction(context, jsonData: subJson)
        }
    }
    
    class func newTransaction (context:NSManagedObjectContext, jsonData:JSON) -> TFTransaction {
        
        return TFTransaction (context: context,
            id: jsonData["objectId"].doubleValue,
            amount: jsonData["amount"].doubleValue,
            comment: jsonData["comment"].stringValue,
            date: NSDateFormatter().dateFromString(jsonData["transactionDate"].stringValue),
            descriptionText: jsonData["description"].stringValue,
            category: nil,
            currency: nil,
            recipient: nil)
    }
  
    @objc
    private override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}
