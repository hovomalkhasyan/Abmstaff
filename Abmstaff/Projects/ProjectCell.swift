//
//  ProjectCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/7/20.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var projectImage: UIImageView!
    @IBOutlet weak var projetName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        projectView.layer.borderWidth = 0.3
        projectView.layer.borderColor = UIColor.lightGray.cgColor
        projectView.layer.cornerRadius = 12
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        projectImage.image = UIImage(named: "logo")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
