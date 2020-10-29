//
//  PersonalController.swift
//  Abmstaff
//
//  Created by Hovo on 10/26/20.
//

import UIKit
import Alamofire

class PersonalController: UIViewController {
    var userArray = [DataList]()
    let userDet = "User/Details"
    var fblink : String?
    var instaLink: String?
    var lnLink : String?
    //MARK: - Outlets
    
    
    @IBOutlet weak var adressSwitch: UISwitch!
    @IBOutlet weak var phoneNumberSwitch: UISwitch!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var instaBtn: UIButton!
    @IBOutlet weak var lnBtn: UIButton!
    @IBOutlet weak var privacyView: UIView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var secondPhone: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var career: UILabel!
    @IBOutlet weak var employee: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var userPosition: UILabel!
    @IBOutlet weak var userFullName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            socialButtonsSetups()
        setupSwitch()
        NetWorkService.request(url: userDet, method: .get, param: nil, encoding: JSONEncoding.default) { (response: DataList) in
            self.team.text = response.team
            self.userFullName.text = response.fullName
            self.secondPhone.text = response.secondPhone ?? "-"
            self.adress.text = response.address ?? "-"
            self.phone.text = response.phone
            self.email.text = response.email
            self.userPosition.text = response.positionName
            self.dateOfBirth.text = response.dateOfBirth.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", outGoingFormat: "dd MMM yyy")
            self.employee.text = response.employeeDate.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", outGoingFormat: "dd MMM yyy")
            self.career.text = response.careerStartDate.UTCToLocal(incomingFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'", outGoingFormat: "dd MMM yyy")
            self.fblink = response.facebookLink
            self.instaLink = response.instagramLink
            self.lnLink = response.linkedinLink
            if let urlImage = response.profilePhoto, let url = URL(string: urlImage) {
                self.userImage.sd_setImage(with: url)
            }
            if response.facebookLink != nil {
                self.fbButton.isHidden = false
            }
            if response.instagramLink != nil {
                self.instaBtn.isHidden = false
            }
            if response.linkedinLink != nil{
                self.lnBtn.isHidden = false
            }
            
            
        }
        privacyView.layer.borderWidth = 0.3
        privacyView.layer.borderColor = UIColor.lightGray.cgColor
        privacyView.layer.cornerRadius = 13
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Personal information"
    }
    
    private func socialButtonsSetups() {
        fbButton.isHidden = true
        instaBtn.isHidden = true
        lnBtn.isHidden = true
    }
    
    private func setupSwitch() {
        adressSwitch.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        phoneNumberSwitch.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }

    @IBAction func socialMedia(_ sender: UIButton) {
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
