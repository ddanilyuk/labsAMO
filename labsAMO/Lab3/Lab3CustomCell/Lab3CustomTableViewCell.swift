//
//  Lab3CustomTableViewCell.swift
//  labsAMO
//
//  Created by Денис Данилюк on 28.03.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class Lab3CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var deltaNLabel: UILabel!
    @IBOutlet weak var deltaNNLabel: UILabel!
    @IBOutlet weak var kLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
