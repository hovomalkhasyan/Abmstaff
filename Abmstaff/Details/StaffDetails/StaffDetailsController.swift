//
//  StaffDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire
import MessageUI

class StaffDetailsController: UIViewController {
    var edpoint = "User/StaffDetails/"
    var id = 0
    var phoneNumber = ""
    var mail = ""
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var date: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: edpoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: UserDetailsId ) in
            self.callButton.setTitle(response.phone, for: .normal)
            self.lastName.text = response.fullName
            self.mail = response.email
            self.email.setTitle(response.email, for: .normal)
            self.team.text = response.team
            self.date.text = response.dateOfBirth?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'H:mm:ss'Z'", outGoingFormat: "dd/MM/yyyy")
            if let urlImage = response.profilePhoto, let url = URL(string: urlImage) {
                self.avatar.load(url: url)
            }
            if let phone = response.phone {
                self.phoneNumber = phone
            }
        }
    }
    func sendEmail() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([mail])
        
        present(mailVC, animated: true, completion: nil)
    }
    
    @IBAction func callNumber(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        sendEmail()
    }
}

extension StaffDetailsController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
