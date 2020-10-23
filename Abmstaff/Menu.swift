//
//  Menu.swift
//  Abmstaff
//
//  Created by Hovo on 10/7/20.
//

import Foundation
import SideMenu
 
class MenuListController : UITableViewController {
    
    var modeArray = ["Home", "Staff", "Projects", "Partners", "Settings", "Logout"]
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
            let projectStory = UIStoryboard(name: "Project", bundle: nil).instantiateViewController(identifier: "ProjectController")
            navigationController?.pushViewController(projectStory, animated: true)
        case 3:
            let partnersStory = UIStoryboard(name: "Partners", bundle: nil).instantiateViewController(identifier: "PartnersController")
            navigationController?.pushViewController(partnersStory, animated: true)
        case 4:
            let settingsStory = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(identifier: "SettingsController")
            navigationController?.pushViewController(settingsStory, animated: true)
        case 5:
         break
        default:
            break
        }
    }

}
