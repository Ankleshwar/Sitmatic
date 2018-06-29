//
//  HeaderCell.swift
//  Sitmatic
//
//  Created by Opiant tech Solutions Pvt. Ltd. on 29/06/18.
//  Copyright © 2018 Ankleshwar. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var lblSelected: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var toggleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
