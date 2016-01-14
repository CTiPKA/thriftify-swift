//
//  TFRecipient+CoreDataProperties.swift
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

extension TFRecipient {

    @NSManaged var address: String?
    @NSManaged var name: String?
    @NSManaged var recipientId: NSNumber?
    @NSManaged var transactions: NSSet?

}
