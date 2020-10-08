//
//  ProjectCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/7/20.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projetName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
