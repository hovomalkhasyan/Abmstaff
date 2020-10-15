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
    var array = [DataList]()
    let userDet = "User/Details"
    var menu : SideMenuNavigationController?
    let menuListController = MenuListController()
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fatherName: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var dateBirth: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var carierStart: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var employe: UILabel!
    @IBOutlet weak var adress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: userDet, method: .get, param: nil, encoding: JSONEncoding.default) { (response: DataList) in
            self.nameLabel.text = response.firstName
            self.lastNameLbl.text = response.lastName
            self.dateBirth.text = response.dateOfBirth
            self.email.text = response.email
            self.team.text = response.team
            self.fatherName.text = response.fatherName
            self.carierStart.text = response.careerStartDate
            self.phone.text = response.phone
            self.employe.text = response.employeeDate
            self.adress.text = response.address
        }
        sideMenuSetups()
       
    }
 
    @objc func leftButton() {
        present(self.menu!, animated: true)
    }
    
    private func sideMenuSetups() {
        menu = SideMenuNavigationController(rootViewController: menuListController)
        menu?.leftSide = true
        self.title = "Abmstaf"
        let newBtn = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(leftButton))
        self.navigationItem.leftBarButtonItem = newBtn
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func swipeMenu(_ sender: UISwipeGestureRecognizer) {
        present(self.menu!, animated: true)
    }
    
}

