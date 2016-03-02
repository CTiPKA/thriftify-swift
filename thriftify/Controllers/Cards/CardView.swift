//
//  CardViewCell.swift
//  thriftify
//
//  Created by Vitalij on 17.02.16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var sum: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var typeLogo: UIImageView!
    @IBOutlet weak var cardholder: UILabel!
    @IBOutlet weak var type: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let view = NSBundle.mainBundle().loadNibNamed("CardView", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }

    
/*
if (self = super.initWithCoder(aDecoder)){
self.addSubview
[[[NSBundle mainBundle] loadNibNamed:@"MyCustomTimerView"
owner:self
options:nil] objectAtIndex:0]];
return self;
}

    }
*/

    func configureCell(card: TFCard) {
        if let _ = card.number {
            number.text = card.strarredNumber
        }
        
        if let cholder = card.cardholder {
            cardholder.text = cholder as String
        }
    }

    
}
