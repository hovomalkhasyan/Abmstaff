//
//  UserController.swift
//  Abmstaff
//
//  Created by Hovo on 10/1/20.
//

import UIKit
import Alamofire


class UserController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userPosition: UILabel!
    @IBOutlet weak var userName: UILabel!
    var userArray = [UserInfo]()
    let userDet = "User/Details"
    var id = 0
    var attributesArray = ["Personal information", "My team", "Salary", "Vacation", "Cloud", "Log out"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        NetWorkService.request(url: userDet, method: .get, param: nil, encoding: JSONEncoding.default) { (response: UserInfo) in
            self.userName.text = response.fullName
            self.userPosition.text = response.positionName
            if let urlImage = response.profilePhoto, let url = URL(string: urlImage) {
                self.userImage.sd_setImage(with: url)
            }
            self.id = response.teamId ?? 0

        }
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
       
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure want to log out ?", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Log Out", style: .default) { (alert) in
            let loginStory = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
            UIApplication.shared.windows.first?.rootViewController = loginStory
            UserDefaults.standard.removeObject(forKey: "token")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func navigationSetup() {
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.isNavigationBarHidden = false
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
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let personal = UIStoryboard(name: "Personal", bundle: nil).instantiateViewController(identifier: "PersonalController") as! PersonalController
            navigationController?.pushViewController(personal, animated: true)
        case 1:
            let myteam = UIStoryboard(name: "Team", bundle: nil).instantiateViewController(identifier: "TeamController") as! TeamController
            myteam.teamId = id
            navigationController?.pushViewController(myteam, animated: true)
        case 5:
            showAlert()
        default:
            break
        }
    }
    
    
}

