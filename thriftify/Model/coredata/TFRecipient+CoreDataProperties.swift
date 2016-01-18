//
//  TFRecipient+CoreDataProperties.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/19/16.
//  Copyright © 2016 vt. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TFRecipient {

    @NSManaged var address: String?
    @NSManaged var name: String?
    @NSManaged var identifier: String?
    @NSManaged var transactions: NSSet?

}
