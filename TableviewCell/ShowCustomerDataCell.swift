//
//  ShowCustomerDataCell.swift
//  Customer
//
//  Created by Lucky on 30/08/19.
//  Copyright © 2019 Lucky. All rights reserved.
//

import UIKit

class ShowCustomerDataCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var pNumber: UILabel!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var customerCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
