//
//  ProjectDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class ProjectDetailsController: UIViewController {
    var projectDetailsEndPoint = "Project/Details/5"
    @IBOutlet weak var projectName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: projectDetailsEndPoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: ProjectDetailsID) in
            self.projectName.text = response.name
        }
    }
    
}
