//
//  HomeCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/22/20.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var imageProjcet: UIImageView!
    @IBOutlet weak var nameProject: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
