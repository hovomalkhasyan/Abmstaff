//
//  StaffDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class StaffDetailsController: UIViewController {
    var edpoint = "User/StaffDetails/"
    var id = 0
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var date: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: edpoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: UserDetailsId ) in
            self.userName.text = response.firstName
            self.lastName.text = response.lastName
            self.email.text = response.email
            self.team.text = response.team
            self.date.text = response.dateOfBirth
            if let urlImage = response.profilePhoto, let url = URL(string: urlImage) {
                self.avatar.load(url: url)
            }
        }
    }
}
