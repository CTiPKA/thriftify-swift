//
//  TransactionTableViewCell.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 1/17/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    let greyishBrown = UIColor.init(red: 84.0/255.0, green: 84.0/255.0, blue: 84.0/255.0, alpha: 1)
    let charcoalGrey = UIColor.init(red: 53.0/255.0, green: 53.0/255.0, blue: 54.0/255.0, alpha: 1)
    let darkishPink = UIColor.init(red: 213.0/255.0, green: 74.0/255.0, blue: 113.0/255.0, alpha: 1)

    @IBOutlet weak var cellTypeImage: UIImageView!
    @IBOutlet weak var cellDetiledTypeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
