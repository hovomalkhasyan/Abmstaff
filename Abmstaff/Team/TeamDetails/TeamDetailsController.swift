//
//  TeamDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class TeamDetailsController: UIViewController {
    var detailsEndPoint = "Team/Details/12"
    @IBOutlet weak var teamName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: detailsEndPoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: TeamDetailsID ) in
            self.teamName.text = response.name
        }
    }
    
}
