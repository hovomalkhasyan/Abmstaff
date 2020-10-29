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
    var phoneNumber : String?
    var secondPhoneNumber: String?
    var mail = ""
    private var fblink: String?
    private var instaLink: String?
    private var lnLink: String?
    @IBOutlet weak var lnBtn: UIButton!
    @IBOutlet weak var instBtn: UIButton!
    @IBOutlet weak var fbButon: UIButton!
    @IBOutlet weak var employee: UILabel!
    @IBOutlet weak var careerStart: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var secondPhone: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var userPosition: UILabel!
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var date: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSocialButtons()
        NetWorkService.request(url: edpoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: UserDetailsId ) in
            self.userPosition.text = response.positionName
            self.callButton.setTitle(response.phone ?? "-", for: .normal)
            self.secondPhone.setTitle(response.secondPhone ?? "-", for: .normal)
            self.lastName.text = response.fullName
            self.mail = response.email
            self.email.setTitle(response.email ?? "-", for: .normal)
            self.team.text = response.team
            self.date.text = response.dateOfBirth?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'H:mm:ss'Z'", outGoingFormat: "dd/MMM/yyyy")
            self.employee.text = response.employeeDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'H:mm:ss'Z'", outGoingFormat: "dd/MMM/yyyy")
            self.careerStart.text = response.careerStartDate?.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'H:mm:ss'Z'", outGoingFormat: "dd/MMM/yyyy")
            self.adress.text = response.address ?? "-"
            if let urlImage = response.profilePhoto, let url = URL(string: urlImage) {
                self.avatar.load(url: url)
            }
            
            if let phone = response.phone, let second = response.secondPhone {
                self.phoneNumber = phone
                self.secondPhoneNumber = second
                
                
                if response.facebookLink != nil {
                    self.fblink = response.facebookLink
                    self.fbButon.isHidden = false
                }
                if response.instagramLink != nil {
                    self.instaLink = response.instagramLink
                    self.instBtn.isHidden = false
                }
                if response.linkedinLink != nil{
                    self.lnLink = response.linkedinLink
                    self.lnBtn.isHidden = false
                }
                
            }
        }
    }
    
    private func setupSocialButtons() {
        fbButon.isHidden = true
        instBtn.isHidden = true
        lnBtn.isHidden = true
    }
    
    func sendEmail() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([mail])
        
        present(mailVC, animated: true, completion: nil)
    }
    
    @IBAction func callNumber(_ sender: UIButton) {
        if sender.tag == 0 {
            guard let phoneNumber = phoneNumber else {return}
            guard let number = URL(string: "tel://" + phoneNumber) else { return }
            UIApplication.shared.open(number)
        }else {
            guard let secondNumber = secondPhoneNumber else {return}
            guard let number = URL(string: "tel://" + secondNumber) else { return }
            UIApplication.shared.open(number)
        }
       
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        sendEmail()
    }
    
    @IBAction func goTosocial(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            guard let link = fblink else {return}
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        case 1:
            guard let link = instaLink else {return}
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        case 2:
            guard let link = lnLink else {return}
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        default:
            break
        }
    }
}

extension StaffDetailsController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
