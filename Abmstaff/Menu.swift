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
        if indexPath.row == 0 {
            let newVC = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "navigation")
            UIApplication.shared.windows.first?.rootViewController = newVC
        } else if indexPath.row == 1 {
            let staffStory = UIStoryboard(name: "Staff", bundle: nil).instantiateViewController(identifier: "StaffController")
            navigationController?.pushViewController(staffStory, animated: true)
        }else if indexPath.row == 2 {
            let teamStory = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TeamViewController")
            navigationController?.pushViewController(teamStory, animated: true)
        }else if indexPath.row == 3 {
            let projectStory = UIStoryboard(name: "Project", bundle: nil).instantiateViewController(identifier: "ProjectController")
            navigationController?.pushViewController(projectStory, animated: true)
        }else if indexPath.row == 4 {
            let partnersStory = UIStoryboard(name: "Partners", bundle: nil).instantiateViewController(identifier: "PartnersController")
            navigationController?.pushViewController(partnersStory, animated: true)
        }else if indexPath.row == 5 {
            let settingsStory = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(identifier: "SettingsController")
            navigationController?.pushViewController(settingsStory, animated: true)
        }else if indexPath.row == 6 {
            let loginStory = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
            UIApplication.shared.windows.first?.rootViewController = loginStory
            UserDefaults.standard.removeObject(forKey: "token")
        }
    }
    
}
