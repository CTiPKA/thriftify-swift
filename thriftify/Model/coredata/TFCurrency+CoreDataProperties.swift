//
//  TFCurrency+CoreDataProperties.swift
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

extension TFCurrency {

    @NSManaged var code: String?
    @NSManaged var currencyId: NSNumber?
    @NSManaged var name: String?
    @NSManaged var transactions: NSSet?

}
