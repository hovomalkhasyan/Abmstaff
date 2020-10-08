//
//  StaffCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/6/20.
//

import UIKit

class StaffCell: UITableViewCell {

    @IBOutlet weak var userLastName: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
