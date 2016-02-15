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

@IBDesignable
class RoundRectView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.blackColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
}

//extension UIView {
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    @IBInspectable var borderColor: UIColor{
//        get {
//            return UIColor(CGColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue.CGColor
//        }
//    }

//}