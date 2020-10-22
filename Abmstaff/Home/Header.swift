//
//  Header.swift
//  Abmstaff
//
//  Created by Hovo on 10/22/20.
//

import UIKit

class Header: UITableViewCell {

    @IBOutlet weak var titleOfHeader: UILabel!
    @IBOutlet weak var iconeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
