//
//  PartnersCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/15/20.
//

import UIKit

class PartnersCell: UITableViewCell {
    
    
    @IBOutlet weak var project: UILabel!
    @IBOutlet weak var partnerView: UIView!
    @IBOutlet weak var partnerName: UILabel!
    @IBOutlet weak var partnersAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        partnerView.layer.borderWidth = 0.3
        partnerView.layer.borderColor = UIColor.lightGray.cgColor
        partnerView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        partnersAvatar.image = UIImage(named: "logo")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
