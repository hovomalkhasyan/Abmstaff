//
//  VacationHistoryCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/27/20.
//

import UIKit

class VacationHistoryCell: UITableViewCell {

    @IBOutlet weak var totalDays: UILabel!
    @IBOutlet weak var dayTo: UILabel!
    @IBOutlet weak var dayFrom: UILabel!
    @IBOutlet weak var vacationHistoryView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
