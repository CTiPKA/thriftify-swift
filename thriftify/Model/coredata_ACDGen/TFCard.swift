//
//  TFCard.swift
//

import Foundation
import CoreData

public class TFCard: NSManagedObject {

    static let entityName = "TFCard"

    var strarredNumber : String {
        get {
            let cnumber = String(number!)
            let result = (cnumber.characters.count == 16) ? "\((cnumber as NSString).substringToIndex(4)) ****  **** \((cnumber as NSString).substringFromIndex(12))" : "Wrong card number"
            return result
        }
    }
}

