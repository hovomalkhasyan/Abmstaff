//
//  TechnologiesCell.swift
//  Abmstaff
//
//  Created by Hovo on 11/4/20.
//

import UIKit

class TechnologiesCell: UITableViewCell {
    
    @IBOutlet weak var technoView: UIView!
    @IBOutlet weak var technoCount: UILabel!
    @IBOutlet weak var technoType: UILabel!
    @IBOutlet weak var technoName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTechnoView()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupTechnoView() {
        technoView.layer.borderWidth = 0.3
        technoView.layer.borderColor = UIColor.lightGray.cgColor
        technoView.layer.cornerRadius = 10
        
    }
    
}
