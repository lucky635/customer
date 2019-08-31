//
//  CheckInCell.swift
//  Customer
//
//  Created by Lucky on 30/08/19.
//  Copyright © 2019 Lucky. All rights reserved.
//

import UIKit

class CheckInCell: UITableViewCell {

    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
