//
//  TeamViewController.swift
//  Abmstaff
//
//  Created by Hovo on 10/22/20.
//

import UIKit
import Alamofire

class TeamViewController: UIViewController {
    private let teamUrlEndPoint = "Team/GetAll"
    private var teamArray = [TeamList]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getAllteam()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
        
    }
    
    
    private func getAllteam() {
        
        NetWorkService.request(url: teamUrlEndPoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [TeamList]) in
            self.teamArray = response
            self.tableView.reloadData()
        }
    }
    
}

extension TeamViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCells", for: indexPath) as! TeamCells
        cell.member.text = String(teamArray[indexPath.row].membersCount)
        cell.project.text = String(teamArray[indexPath.row].projectsCount)
        cell.team.text = teamArray[indexPath.row].name
        cell.teamView.layer.borderWidth = 0.3
        cell.teamView.layer.borderColor = UIColor.lightGray.cgColor
        cell.teamView.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = UIStoryboard(name: "TeamDetails", bundle: nil).instantiateViewController(identifier: "TeamDetailsController") as! TeamDetailsController
        newVC.id = teamArray[indexPath.row].id
        navigationController?.pushViewController(newVC, animated: true)
    }
}
