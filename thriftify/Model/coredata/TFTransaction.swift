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
import JSQCoreDataKit

class TFTransaction: NSManagedObject {
    
    static let entityName = "TFTransaction"
    
    init(context: NSManagedObjectContext,
        identifier: String,
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
        
        self.identifier = identifier
        self.amount = amount
        self.comment = comment
        self.date = date
        self.descriptionText = descriptionText
        self.category = category
        self.currency = currency
        self.recipient = recipient
    }
    
    class func objectWithId(context:NSManagedObjectContext, id:String) -> TFTransaction? {
        let entity = NSEntityDescription.entityForName(TFTransaction.entityName, inManagedObjectContext: context)!
        let request = FetchRequest<TFTransaction>(entity: entity)
        request.predicate = NSPredicate.init(format: "identifier == \"\(id)\"", argumentArray: nil)
        
        var results = [TFTransaction]()
        do {
            results = try fetch(request: request, inContext: context)
        }
        catch {
            print("Fetch error: \(error)")
        }
        
        print("Fetch results = \(results)")
        return results.first
    }
    
    class func newTransactions (context:NSManagedObjectContext, jsonData:JSON) {
        for (index,subJson):(String, JSON) in jsonData {
            print("index (\(index)): \(subJson)")
            TFTransaction.newTransaction(context, jsonData: subJson)
        }
    }
    
    class func newTransaction (context:NSManagedObjectContext, jsonData:JSON) -> TFTransaction? {
        
        if let transaction = TFTransaction.objectWithId(context, id: jsonData["objectId"].stringValue) {
            //updating values
            transaction.identifier = jsonData["objectId"].stringValue
            transaction.amount = jsonData["amount"].doubleValue
            transaction.comment = jsonData["comment"].stringValue
            transaction.date = NSDateFormatter().dateFromString(jsonData["transactionDate"].stringValue)
            transaction.descriptionText = jsonData["description"].stringValue
            transaction.category = nil
            transaction.currency = nil
            transaction.recipient = nil
            
            return transaction
        } else {
            //initialize new object
            return TFTransaction (context: context,
                identifier: jsonData["objectId"].stringValue,
                amount: jsonData["amount"].doubleValue,
                comment: jsonData["comment"].stringValue,
                date: NSDateFormatter().dateFromString(jsonData["transactionDate"].stringValue),
                descriptionText: jsonData["description"].stringValue,
                category: nil,
                currency: nil,
                recipient: nil)
        }
    }
  
    @objc
    private override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}
