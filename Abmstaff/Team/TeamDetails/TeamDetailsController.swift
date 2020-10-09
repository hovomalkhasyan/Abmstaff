//
//  TeamDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class TeamDetailsController: UIViewController {
    var detailsEndPoint = "Team/Details/"
    @IBOutlet weak var teamName: UILabel!
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: detailsEndPoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: TeamDetailsID ) in
            self.teamName.text = response.name
        }
    }
    
}
