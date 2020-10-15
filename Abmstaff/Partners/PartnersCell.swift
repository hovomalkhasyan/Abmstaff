//
//  PartnersCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/15/20.
//

import UIKit

class PartnersCell: UITableViewCell {

    @IBOutlet weak var partnerName: UILabel!
    @IBOutlet weak var partnersAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
