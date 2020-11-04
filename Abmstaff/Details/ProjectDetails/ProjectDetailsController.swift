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
    var members = [DetailMember]()
    var platform = [Platform]()
    @IBOutlet weak var platformTableView: UITableView!
    @IBOutlet weak var memberTableView: UITableView!
    @IBOutlet weak var projectPhoto: UIImageView!
    @IBOutlet weak var teamLbl: UILabel!
    @IBOutlet weak var projectName: UILabel!
    
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: projectDetailsEndPoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: ProjectDetailsID) in
            self.projectName.text = response.name
            self.teamLbl.text = response.teamName
            
            if let urlImage = response.image, let url = URL(string: urlImage) {
                self.projectPhoto.sd_setImage(with: url)
            }
            self.members = response.members
            self.platform = response.platforms
            self.memberTableView.reloadData()
            self.platformTableView.reloadData()
        }
        
        
    }
    
    private func setupTableView() {
        memberTableView.delegate = self
        memberTableView.dataSource = self
        platformTableView.delegate = self
        platformTableView.dataSource = self
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            platformTableView.isHidden = true
            memberTableView.isHidden = false
            memberTableView.reloadData()
        case 1:
            memberTableView.isHidden = true
            platformTableView.isHidden = false
            platformTableView.reloadData()
        default:
            break
        }
    }
    
}
extension ProjectDetailsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == memberTableView {
            return members.count
        } else {
            return platform.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == memberTableView {
            let cell = memberTableView.dequeueReusableCell(withIdentifier: "MembersCell", for: indexPath) as! MembersCell
            cell.memberName.text = members[indexPath.row].fullName
            if let urlImage = members[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
                cell.memberImage.sd_setImage(with: url)
            }
            return cell
        } else {
            let cell = platformTableView.dequeueReusableCell(withIdentifier: "PlatformCell", for: indexPath) as! PlatformCell
            cell.platformName.text = platform[indexPath.row].name
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case memberTableView:
            let newVC = UIStoryboard(name: "StaffDetails", bundle: nil).instantiateViewController(identifier: "StaffDetailsController") as! StaffDetailsController
            newVC.id = members[indexPath.row].id
            navigationController?.pushViewController(newVC, animated: true)
        default:
            break
        }
    }
    
}
