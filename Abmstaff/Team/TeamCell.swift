//
//  TeamCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/6/20.
//

import UIKit

class TeamCell: UITableViewCell {

    @IBOutlet weak var projectCount: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
