//
//  TeamCells.swift
//  Abmstaff
//
//  Created by Hovo on 10/19/20.
//

import UIKit

class TeamCells: UITableViewCell {

    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var project: UILabel!
    @IBOutlet weak var member: UILabel!
    @IBOutlet weak var team: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
