//
//  StaffController.swift
//  Abmstaff
//
//  Created by Hovo on 10/6/20.
//

import UIKit
import Alamofire

class StaffController: UIViewController {
    var staffArray = [StaffList]()
    let staffEndpoint = "User/GetStaffAllList"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: staffEndpoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [StaffList]) in
            self.staffArray = response
            self.tableView.reloadData()
        }
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
extension StaffController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaffCell", for: indexPath) as! StaffCell
        if let urlImage = staffArray[indexPath.row].profilePhoto, let url = URL(string: urlImage) {
            cell.userAvatar.load(url: url)
        }
        cell.userLastName.text = staffArray[indexPath.row].lastName
        cell.userName.text = staffArray[indexPath.row].firstName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = UIStoryboard(name: "StaffDetails", bundle: nil).instantiateViewController(identifier: "StaffDetailsController") as! StaffDetailsController
        navigationController?.pushViewController(newVC, animated: true)
    }
    
}

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
