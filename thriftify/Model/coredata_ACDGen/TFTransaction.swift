//
//  TFTransaction.swift
//

import Foundation
import CoreData

import AlecrimCoreData
import SwiftyJSON

public class TFTransaction: NSManagedObject {

    static let entityName = "TFTransaction"
    
//    class func objectWithId (identifier:String) -> TFTransaction? {
//        let transaction = DataContext().tftransactions.first({ $0.identifier == identifier })
//        return transaction
//    }
//    
//    class func newTransactions (jsonData:JSON) {
//        for (_,subJson):(String, JSON) in jsonData {
////            print("index (\(index)): \(subJson)")
//            newTransaction (subJson)
//        }
//        
//        do {
//            try DataContext().save()
//        }
//        catch let error {
//            // do a nice error handling here
//            print(error)
//        }
//    }
//    
//    class func newTransaction (jsonData:JSON) -> TFTransaction? {
//        
//        let transaction = DataContext().tftransactions.firstOrCreated { $0.identifier == jsonData["objectId"].stringValue }
//            //updating values
//            transaction.amount = jsonData["amount"].doubleValue
//            transaction.comment = jsonData["comment"].stringValue
//            transaction.date = NSDateFormatter().dateFromString(jsonData["transactionDate"].stringValue)
//            transaction.descriptionText = jsonData["description"].stringValue
//            transaction.category = nil
//            transaction.currency = nil
//            transaction.recipient = nil
//            
//            return transaction
//    }
    
}

