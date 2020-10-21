//
//  TeamProjectCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/19/20.
//

import UIKit

class TeamProjectCell: UITableViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
