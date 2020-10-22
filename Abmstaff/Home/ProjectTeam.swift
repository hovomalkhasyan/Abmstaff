//
//  ProjectTeam.swift
//  Abmstaff
//
//  Created by Hovo on 10/22/20.
//

import UIKit

class ProjectTeam: UITableViewCell {

    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projectName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        teamView.layer.borderWidth = 0.3
        teamView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
