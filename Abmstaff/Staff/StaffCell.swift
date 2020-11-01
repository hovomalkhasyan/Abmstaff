//
//  StaffCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/6/20.
//

import UIKit

class StaffCell: UITableViewCell {
    
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    override func awakeFromNib() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userAvatar.image = UIImage(named: "logo")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
