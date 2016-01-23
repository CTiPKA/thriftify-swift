//
//  TFTransaction.swift
//

import Foundation
import CoreData

import AlecrimCoreData
import SwiftyJSON

public class TFTransaction: NSManagedObject {

    var month : String {
        // 2016-01-21T12:18:52.693Z
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM '' yy"
        
        if date == nil {
            return ""
        } else {
            let monthFormatted = formatter.stringFromDate(date!)
            return monthFormatted
        }
    }
    
    static let entityName = "TFTransaction"

}

