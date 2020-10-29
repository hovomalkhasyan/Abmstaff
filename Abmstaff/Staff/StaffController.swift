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
    private var staffArray = [AllStaffDetails]()
    private var teamArray = [TeamList]()
    
// MARK: - EndPoints
    private let staffEndpoint = "User/StaffListDetails"
    private let teamUrlEndPoint = "Team/GetAll"

// MARK: - IBOutlets
    @IBOutlet weak var membersTableView: UITableView!
 
    
    // MARK: - LifeSycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: staffEndpoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [AllStaffDetails]) in
            self.staffArray = response
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
    
// MARK: - IBAtion
    
// MARK: - TableViewExtensions
extension StaffController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return staffArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = membersTableView.dequeueReusableCell(withIdentifier: "StaffCell", for: indexPath) as! StaffCell
            if let urlImage = staffArray[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
                cell.userAvatar.sd_setImage(with: url, placeholderImage: UIImage(named: "logo"))
            }
            cell.userName.text = staffArray[indexPath.row].fullName
            cell.phoneNumber.text = staffArray[indexPath.row].phone
            cell.userView.layer.borderWidth = 0.3
            cell.userView.layer.borderColor = UIColor.lightGray.cgColor
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
            return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            let newVC = UIStoryboard(name: "StaffDetails", bundle: nil).instantiateViewController(identifier: "StaffDetailsController") as! StaffDetailsController
            newVC.id = staffArray[indexPath.row].id
            navigationController?.pushViewController(newVC, animated: true)
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

