//
//  PartnerDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/15/20.
//

import UIKit
import Alamofire

class PartnerDetailsController: UIViewController {
    private var partnerDetailsApi = "Partner/Details/"
    var id = 0
    @IBOutlet weak var partnersName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: partnerDetailsApi + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: PartnerDetails) in
            self.partnersName.text = response.companyName
        }
    }


}
