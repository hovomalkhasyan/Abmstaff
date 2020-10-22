//
//  AttributesCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/22/20.
//

import UIKit

class AttributesCell: UITableViewCell {

    @IBOutlet weak var attributesImage: UIImageView!
    @IBOutlet weak var attributesView: UIView!
    @IBOutlet weak var attributesLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
