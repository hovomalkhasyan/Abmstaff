//
//  TeamViewController.swift
//  Abmstaff
//
//  Created by Hovo on 10/6/20.
//

import UIKit
import Alamofire

class TeamViewController: UIViewController {
    var teamArray = [TeamList]()
    let teamUrlEndPoint = "Team/GetAll"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        NetWorkService.request(url: teamUrlEndPoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [TeamList]) in
            self.teamArray = response
            self.tableView.reloadData()
        }
        self.title = "Team"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
   
    private func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension TeamViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
        cell.teamName.text = teamArray[indexPath.row].name
        cell.projectCount.text = String(teamArray[indexPath.row].projectsCount)
        cell.membersCount.text = String(teamArray[indexPath.row].membersCount)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetails = UIStoryboard(name: "TeamDetails", bundle: nil).instantiateViewController(identifier: "TeamDetailsController") as! TeamDetailsController
        teamDetails.id = teamArray[indexPath.row].id
        navigationController?.pushViewController(teamDetails, animated: true)
        
    }
    
}
