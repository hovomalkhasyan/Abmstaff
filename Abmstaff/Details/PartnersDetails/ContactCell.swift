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
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func sendEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            if let mail = email {
                mailVC.setToRecipients([mail])
            }
            UIApplication.shared.windows.first?.rootViewController?.present(mailVC, animated: true)
            
        } else {
            let alert = UIAlertController(title: "You can not send email", message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
            
        }
        
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        sendEmail()
        
    }
    
    @IBAction func callPhoneNumber(_ sender: UIButton) {
        
        switch sender.tag {
        
        case 0:
            if let phoneNumbers = phoneNumber {
                guard let number = URL(string: "tel://" + phoneNumbers) else { return }
                UIApplication.shared.open(number)
            }
            
        case 2:
            if let secondNumber = secondPhone {
                guard let number = URL(string: "tel://" + secondNumber) else { return }
                UIApplication.shared.open(number)
            }
            
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
