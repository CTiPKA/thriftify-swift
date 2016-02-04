//
//  MonthCategoryCell.swift
//  thriftify
//
//  Created by Vadim Trulyaev on 2/2/16.
//  Copyright © 2016 vt. All rights reserved.
//

import UIKit

class MonthCategoryCell: UITableViewCell {

    @IBOutlet weak var monthTitle: UILabel!
    @IBOutlet weak var mothAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
