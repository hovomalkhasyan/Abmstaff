//
//  ContactCell.swift
//  Abmstaff
//
//  Created by Hovo on 10/30/20.
//

import UIKit
import MessageUI

class ContactCell: UITableViewCell {
    var phoneNumber: String?
    var secondPhone : String?
    var email : String?
    @IBOutlet weak var emailBtn: UIButton!
    @IBOutlet weak var secondPhoneBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var personeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func sendEmail() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        guard let mail = email else {return}
        mailVC.setToRecipients([mail])
        UIApplication.shared.windows.first?.rootViewController?.present(mailVC, animated: true)
        
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        sendEmail()
    }
    @IBAction func callPhoneNumber(_ sender: UIButton) {
       
        switch sender.tag {
        case 0:
            guard let phoneNumber = phoneNumber else {return}
            guard let number = URL(string: "tel://" + phoneNumber) else { return }
            UIApplication.shared.open(number)
        case 2:
            guard let secondNumber = secondPhone else {return}
            guard let number = URL(string: "tel://" + secondNumber) else { return }
            UIApplication.shared.open(number)
        default:
            break
        }
    }
}


extension ContactCell: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
