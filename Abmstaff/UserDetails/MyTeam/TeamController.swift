//
//  TeamController.swift
//  Abmstaff
//
//  Created by Hovo on 10/26/20.
//

import UIKit
import Alamofire

class TeamController: UIViewController {
    var teamId = 0
    @IBOutlet var teamCount: UILabel!
    private var members = [Member]()
    private let userDet = "Team/Details/"
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: userDet + String(teamId), method: .get, param: nil, encoding: JSONEncoding.default) { (response: TeamDetailsID) in
            self.members = response.members
            self.tableView.reloadData()
            self.teamCount.text = "\(response.name) (\(self.members.count))"
        }
        self.navigationController?.isNavigationBarHidden = false
        setupTableview()
    }
    private func setupTableview() {
        tableView.dataSource = self
        tableView.delegate = self
        self.title = "My Team" 
    }

}

extension TeamController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
        if let urlImage = members[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
            cell.userImage.sd_setImage(with:url)
        }
        cell.userName.text = members[indexPath.row].fullName
        cell.userStatus.text = members[indexPath.row].position
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = UIStoryboard(name: "StaffDetails", bundle: nil).instantiateViewController(identifier: "StaffDetailsController") as! StaffDetailsController
        newVC.id = members[indexPath.row].id
        navigationController?.pushViewController(newVC, animated: true)
    }
}

