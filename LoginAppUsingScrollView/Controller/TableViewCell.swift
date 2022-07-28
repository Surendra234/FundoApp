//
//  TableViewCell.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 25/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
