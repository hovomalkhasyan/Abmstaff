//
//  TeamDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class TeamDetailsController: UIViewController {
    @IBOutlet weak var segmentContoll: UISegmentedControl!
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var membersTableView: UITableView!
    var detailsEndPoint = "Team/Details/"
    var members = [Member]()
    var teamProject = [TeamProject]()
    var id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        NetWorkService.request(url: detailsEndPoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: TeamDetailsID ) in
            self.title = response.name
            self.members = response.members
            guard let project = response.projects else {return}
            self.teamProject = project
            self.membersTableView.reloadData()
        }
    }
    private func setupTableView() {
        membersTableView.delegate = self
        membersTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            detailTableView.isHidden = true
            membersTableView.isHidden = false
            membersTableView.reloadData()
        case 1:
            membersTableView.isHidden = true
            detailTableView.isHidden = false
            detailTableView.reloadData()
        default:
            break
        }
    }
}

extension TeamDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentContoll.selectedSegmentIndex == 0 && tableView == membersTableView{
            return members.count
        }else {
            return teamProject.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentContoll.selectedSegmentIndex == 0 && tableView == membersTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsCell", for: indexPath) as! TeamDetailsCell
            cell.userName.text = members[indexPath.row].fullName
            cell.position.text = members[indexPath.row].position
            if let urlImage = members[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
                cell.userImage.load(url: url)
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamProjectCell", for: indexPath) as! TeamProjectCell
            cell.teamName.text = teamProject[indexPath.row].name
            if let urlImage = teamProject[indexPath.row].image, let url = URL(string: urlImage) {
                cell.teamImage.load(url: url)
            }
            return cell
        }
    }
}

