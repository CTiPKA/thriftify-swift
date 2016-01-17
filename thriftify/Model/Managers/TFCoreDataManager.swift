//
//  TFCoreDataManager.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/16/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

import JSQCoreDataKit

public let modelName = "thriftify"
public let modelBundle = NSBundle(identifier: "com.vt.thriftify")!

class TFCoreDataManager {
    
    var stack: CoreDataStack!
    
    init () {
        
        // Initialize the Core Data model, this class encapsulates the notion of a .xcdatamodeld file
        // The name passed here should be the name of an .xcdatamodeld file
        let model = CoreDataModel(name: modelName, bundle: modelBundle)
        
        // Initialize a stack with a factory
        let factory = CoreDataStackFactory(model: model)
        
        factory.createStackInBackground { (result: CoreDataStackResult) in
            switch result {
            case .Success(let s):
                self.stack = s
                
            case .Failure(let e):
                print("Error: \(e)")
            }
        }
        
        if model.needsMigration {
            // do migration
        }
    }
    
    
    
    
}
