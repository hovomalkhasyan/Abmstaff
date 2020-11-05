//
//  PlatformCell.swift
//  Abmstaff
//
//  Created by Hovo on 11/4/20.
//

import UIKit

class PlatformCell: UITableViewCell {

    @IBOutlet weak var platformView: UIView!
    @IBOutlet weak var platformName: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPlatforView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupPlatforView() {
        
        platformView.layer.borderWidth = 0.3
        platformView.layer.borderColor = UIColor.lightGray.cgColor
        platformView.layer.cornerRadius = 10
        
    }

}
