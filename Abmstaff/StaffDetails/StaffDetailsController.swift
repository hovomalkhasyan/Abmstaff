//
//  StaffDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class StaffDetailsController: UIViewController {
    var edpoint = "User/StaffDetails/45"
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: edpoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: UserDetailsId ) in
            self.userName.text = response.firstName
        }
    }
}
