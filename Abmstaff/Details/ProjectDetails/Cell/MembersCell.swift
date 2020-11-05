//
//  MembersCell.swift
//  Abmstaff
//
//  Created by Hovo on 11/4/20.
//

import UIKit

class MembersCell: UITableViewCell {
    
    @IBOutlet weak var membersView: UIView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMmbersView()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        memberImage.image = UIImage(named: "logo")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setupMmbersView() {
        membersView.layer.borderWidth = 0.3
        membersView.layer.borderColor = UIColor.lightGray.cgColor
        membersView.layer.cornerRadius = 10
        
    }
    
}
