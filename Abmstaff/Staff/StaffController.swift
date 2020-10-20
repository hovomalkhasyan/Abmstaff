//
//  StaffController.swift
//  Abmstaff
//
//  Created by Hovo on 10/6/20.
//

import UIKit
import Alamofire

class StaffController: UIViewController {

// MARK: - Models
    private var staffArray = [AllStaffDetails]()
    private var teamArray = [TeamList]()
    
// MARK: - EndPoints
    private let staffEndpoint = "User/StaffListDetails"
    private let teamUrlEndPoint = "Team/GetAll"

// MARK: - IBOutlets
    @IBOutlet weak var segmentOut: UISegmentedControl!
    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var teamTableView: UITableView!
    
    // MARK: - LifeSycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: staffEndpoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [AllStaffDetails]) in
            self.staffArray = response
            self.membersTableView.reloadData()
        }
        NetWorkService.request(url: teamUrlEndPoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [TeamList]) in
            self.teamArray = response
            self.membersTableView.reloadData()
        }
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Members"
         
    }

// MARK: - TableViewSetups
    private func setupTableView() {
        membersTableView.delegate = self
        membersTableView.dataSource = self
        teamTableView.delegate = self
        teamTableView.dataSource = self
        teamTableView.separatorStyle = .none
        membersTableView.separatorStyle = .none
        if segmentOut.selectedSegmentIndex == 1 {
            membersTableView.rowHeight = 80
        }
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
    }
    
// MARK: - IBAtions
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            
            membersTableView.reloadData()
        case 1:
            teamTableView.reloadData()
            
        default:
            break
        }
    }
    
}

// MARK: - TableViewExtensions
extension StaffController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentOut.selectedSegmentIndex == 0 {
            return staffArray.count
        }else {
            return teamArray.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentOut.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StaffCell", for: indexPath) as! StaffCell
            if let urlImage = staffArray[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
                cell.userAvatar.load(url: url)
            }
            cell.userName.text = staffArray[indexPath.row].fullName
            cell.phoneNumber.text = staffArray[indexPath.row].phone
            cell.userView.layer.borderWidth = 1
            cell.userView.layer.borderColor = UIColor.lightGray.cgColor
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCells", for: indexPath) as! TeamCells
            cell.member.text = String(teamArray[indexPath.row].membersCount)
            cell.project.text = String(teamArray[indexPath.row].projectsCount)
            cell.team.text = teamArray[indexPath.row].name
            cell.teamView.layer.borderWidth = 1
            cell.teamView.layer.borderColor = UIColor.lightGray.cgColor
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentOut.selectedSegmentIndex {
        case 0:
            let newVC = UIStoryboard(name: "StaffDetails", bundle: nil).instantiateViewController(identifier: "StaffDetailsController") as! StaffDetailsController
            newVC.id = staffArray[indexPath.row].id
            navigationController?.pushViewController(newVC, animated: true)
        case 1:
            let teamDetails = UIStoryboard(name: "TeamDetails", bundle: nil).instantiateViewController(identifier:"TeamDetailsController") as! TeamDetailsController
            teamDetails.id = teamArray[indexPath.row].id
            navigationController?.pushViewController(teamDetails, animated: true)
        default:
            break
        }
    }
}

// MARK: - UIImageViewExtensions
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}

