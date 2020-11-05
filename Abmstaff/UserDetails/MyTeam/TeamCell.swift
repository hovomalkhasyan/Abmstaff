//
//  TeamCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/26/20.
//

import UIKit

class TeamCell: UITableViewCell {
    
    @IBOutlet var teamView: UIView!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userStatus: UILabel!
    @IBOutlet var userName: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setupTeamView()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = UIImage(named: "logo")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setupTeamView() {
        
        teamView.layer.borderWidth = 0.3
        teamView.layer.borderColor = UIColor.lightGray.cgColor
        teamView.layer.cornerRadius = 13
        userImage.layer.cornerRadius = 13
        
    }
    
}
