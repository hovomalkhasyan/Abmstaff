//
//  TeamDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class TeamDetailsController: UIViewController {
    
    private let detailsEndPoint = "Team/Details/"
    private var members = [Member]()
    private var teamProject = [TeamProject]()
    var id = 0
    
    @IBOutlet weak var segmentContoll: UISegmentedControl!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var membersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupTableView()
        getTeamDetails()
        setupSegmentControl()
        
    }
    
    private func setupTableView() {
        
        membersTableView.delegate = self
        membersTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
    }
    
    private func setupSegmentControl() {
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
    }
    
    private func getTeamDetails() {
        
        NetWorkService.request(url: detailsEndPoint + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: TeamDetailsID ) in
            self.title = response.name
            self.members = response.members
            guard let project = response.projects else {return}
            self.teamProject = project
            self.membersTableView.reloadData()
        }

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
        if tableView == self.membersTableView{
            return members.count
        }else {
            return teamProject.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.membersTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsCell", for: indexPath) as! TeamDetailsCell
            cell.userName.text = members[indexPath.row].fullName
            cell.position.text = members[indexPath.row].position
            if let urlImage = members[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
                cell.userImage.sd_setImage(with: url)
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamProjectCell", for: indexPath) as! TeamProjectCell
            cell.teamName.text = teamProject[indexPath.row].name
            if let urlImage = teamProject[indexPath.row].image, let url = URL(string: urlImage) {
                cell.teamImage.sd_setImage(with: url)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.membersTableView  {
            let newVC = UIStoryboard(name: "StaffDetails", bundle: nil).instantiateViewController(identifier: "StaffDetailsController") as! StaffDetailsController
            navigationController?.pushViewController(newVC, animated: true)
            newVC.id = members[indexPath.row].id
        }else {
            let detailsVC = UIStoryboard(name: "ProjectDetails", bundle: nil).instantiateViewController(identifier: "ProjectDetailsController") as! ProjectDetailsController
            navigationController?.pushViewController(detailsVC, animated: true)
            detailsVC.id = teamProject[indexPath.row].id
        }
    }
    
}

