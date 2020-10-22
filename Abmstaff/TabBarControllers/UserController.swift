//
//  UserController.swift
//  Abmstaff
//
//  Created by Hovo on 10/1/20.
//

import UIKit
import Alamofire
import SideMenu

class UserController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userPosition: UILabel!
    @IBOutlet weak var userName: UILabel!
    var userArray = [DataList]()
    let userDet = "User/Details"
    var attributesArray = ["Personal information", "My team", "Salary", "Vacation", "Cloud", "Log out"]
    var menu : SideMenuNavigationController?
    let menuListController = MenuListController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: userDet, method: .get, param: nil, encoding: JSONEncoding.default) { (response: DataList) in
            self.userName.text = response.fullName
            self.userPosition.text = response.positionName
            if let urlImage = response.profilePhoto, let url = URL(string: urlImage) {
                self.userImage.load(url: url)
            }
        }
        setupTableView()
        self.navigationController?.isNavigationBarHidden = true
//        sideMenuSetups()
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func leftButton() {
        present(self.menu!, animated: true)
    }
    
    private func sideMenuSetups() {
        menu = SideMenuNavigationController(rootViewController: menuListController)
        menu?.leftSide = true
        let newBtn = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(leftButton))
        self.navigationItem.leftBarButtonItem = newBtn
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func swipeMenu(_ sender: UISwipeGestureRecognizer) {
        present(self.menu!, animated: true)
    }
    
}
extension UserController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributesCell", for: indexPath) as! AttributesCell
        cell.attributesLbl.text = attributesArray[indexPath.row]
        cell.attributesImage.image = UIImage(named: attributesArray[indexPath.row])
        cell.attributesView.layer.borderWidth = 0.3
        cell.attributesView.layer.borderColor = UIColor.lightGray.cgColor
        cell.attributesView.layer.cornerRadius = 23
        return cell
    }
    
    
}

