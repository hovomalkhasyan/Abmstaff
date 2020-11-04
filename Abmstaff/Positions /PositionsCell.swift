//
//  PositionsCell.swift
//  Abmstaff
//
//  Created by Hovo on 11/4/20.
//

import UIKit

class PositionsCell: UITableViewCell {

    @IBOutlet weak var positionCount: UILabel!
    @IBOutlet weak var positionName: UILabel!
    @IBOutlet weak var positionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        positionView.layer.borderWidth = 0.3
        positionView.layer.borderColor = UIColor.lightGray.cgColor
        positionView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
