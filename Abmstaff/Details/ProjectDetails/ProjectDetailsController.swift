//
//  ProjectDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class ProjectDetailsController: UIViewController {
    var projectDetailsEndPoint = "Project/Details/"
    @IBOutlet weak var projectPhoto: UIImageView!
    @IBOutlet weak var teamLbl: UILabel!
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var dateProject: UILabel!
    
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: projectDetailsEndPoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: ProjectDetailsID) in
            self.projectName.text = response.name
            self.teamLbl.text = response.teamName
            self.dateProject.text = response.createdDt
            if let urlImage = response.image, let url = URL(string: urlImage) {
                self.projectPhoto.sd_setImage(with: url)
            }
        }
    }
    
}
