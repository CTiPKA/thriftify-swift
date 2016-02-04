//
//  TFAppAppearance.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 2/2/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

class TFAppAppearance {

    static let navBarColor = UIColor.init(colorLiteralRed: 0.0/255.0, green: 210.0/255.0, blue: 186.0/255.0, alpha: 1)
    static let navBarTitleColor = UIColor.init(colorLiteralRed: 135.0/255.0, green: 251.0/255.0, blue: 239.0/255.0, alpha: 1)
    
    class func applyAppAppearance () {
        
        //nav bar
//        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().barTintColor = navBarColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: navBarTitleColor]
    }

}
