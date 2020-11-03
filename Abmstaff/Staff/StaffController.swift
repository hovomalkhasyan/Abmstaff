//
//  StaffController.swift
//  Abmstaff
//
//  Created by Hovo on 10/6/20.
//

import UIKit
import Alamofire
import SDWebImage

class StaffController: UIViewController {
    
    // MARK: - Models
    private var userArray = [UserModel]()
    
    // MARK: - EndPoints

    private let getStaff = "User/GetStaffList"
    
    // MARK: - IBOutlets
    @IBOutlet weak var membersTableView: UITableView!
    
    private let paging = [ "count": 15,
                   "page": 1]
    
    // MARK: - LifeSycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        let parameters :  [String : Any?] = [
            "firstName": nil,
            "lastName": nil,
            "email": nil,
            "phone": nil,
            "team": nil,
            "position": nil,
            "isBlocked": false,
            "technology": nil,
            "technologyType": nil,
            "paging" : paging
        ]
        
        NetWorkService.request(url: getStaff, method: .post, param: parameters as Parameters, encoding: JSONEncoding.default) { (response: ResponseData<UserModel>) in
            self.userArray = response.data
            self.membersTableView.reloadData()
        }
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.title = "Members"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - TableViewSetups
    private func setupTableView() {
        membersTableView.delegate = self
        membersTableView.dataSource = self
        membersTableView.contentInset.top = 10
    }
}


// MARK: - TableViewExtensions
extension StaffController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "StaffCell", for: indexPath) as! StaffCell
        if let urlImage = userArray[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
            cell.userAvatar.sd_setImage(with: url, placeholderImage: UIImage(named: "logo"))
        }
        cell.userName.text = userArray[indexPath.row].fullName
        cell.phoneNumber.text = userArray[indexPath.row].phone ?? "-"
        cell.userStatus.text = userArray[indexPath.row].position ?? "-"
        cell.team.text = userArray[indexPath.row].team ?? "-"
        cell.userView.layer.borderWidth = 0.3
        cell.userView.layer.borderColor = UIColor.lightGray.cgColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newVC = UIStoryboard(name: "StaffDetails", bundle: nil).instantiateViewController(identifier: "StaffDetailsController") as! StaffDetailsController
        newVC.id = userArray[indexPath.row].id
        navigationController?.pushViewController(newVC, animated: true)
    }
}


