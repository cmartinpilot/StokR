//
//  CabinetCell.swift
//  StokR
//
//  Created by Christopher Martin on 5/16/17.
//  Copyright © 2017 Christopher Martin. All rights reserved.
//

import UIKit

class CabinetCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var cabinetNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
