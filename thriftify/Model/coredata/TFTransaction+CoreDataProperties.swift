//
//  TFTransaction+CoreDataProperties.swift
//  
//
//  Created by Vadim Trulyaev on 1/15/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TFTransaction {

    @NSManaged var amount: NSNumber?
    @NSManaged var comment: String?
    @NSManaged var date: NSDate?
    @NSManaged var descriptionText: String?
    @NSManaged var category: TFCategory?
    @NSManaged var currency: TFCurrency?
    @NSManaged var recipient: TFRecipient?

}
