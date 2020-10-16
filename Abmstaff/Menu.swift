//
//  Menu.swift
//  Abmstaff
//
//  Created by Hovo on 10/7/20.
//

import Foundation
import SideMenu
 
class MenuListController : UITableViewController {
    
    var modeArray = ["Home", "Staff", "Team", "Projects", "Partners", "Settings", "Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modeArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = modeArray[indexPath.row]
        cell.imageView?.image = UIImage(named: modeArray[indexPath.row])
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let newVC = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "navigation")
            UIApplication.shared.windows.first?.rootViewController = newVC
        case 1:
            let staffStory = UIStoryboard(name: "Staff", bundle: nil).instantiateViewController(identifier: "StaffController")
            navigationController?.pushViewController(staffStory, animated: true)
        case 2:
            let teamStory = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TeamViewController")
            navigationController?.pushViewController(teamStory, animated: true)
        case 3:
            let projectStory = UIStoryboard(name: "Project", bundle: nil).instantiateViewController(identifier: "ProjectController")
            navigationController?.pushViewController(projectStory, animated: true)
        case 4:
            let partnersStory = UIStoryboard(name: "Partners", bundle: nil).instantiateViewController(identifier: "PartnersController")
            navigationController?.pushViewController(partnersStory, animated: true)
        case 5:
            let settingsStory = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(identifier: "SettingsController")
            navigationController?.pushViewController(settingsStory, animated: true)
        case 6:
            showAlert()
        default:
            break
        }
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
}
