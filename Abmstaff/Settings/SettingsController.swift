//
//  SettingsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class SettingsController: UIViewController {
    var settingsArray = [SettingsPlatform]()
    var positionEndPoint = "Position/GetAll"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: positionEndPoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [SettingsPlatform]) in
            self.settingsArray = response
            self.tableView.reloadData()
        }
        let newBtn = UIBarButtonItem(title: "Platforms", style: .plain, target: self, action: #selector(rightButton))
        self.navigationItem.rightBarButtonItem = newBtn
        self.title = "Settings"
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func rightButton() {
        let teamStory = UIStoryboard(name: "Platforms", bundle: nil).instantiateViewController(identifier: "PlatformsController")
        navigationController?.pushViewController(teamStory, animated: true)
    }
    
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.name.text = settingsArray[indexPath.row].name
        cell.count.text = String(settingsArray[indexPath.row].membersCount)
        return cell
        
    }
    
    
}
