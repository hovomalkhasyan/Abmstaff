//
//  ProjectController.swift
//  Abmstaff
//
//  Created by Hovo on 10/7/20.
//

import UIKit
import Alamofire

class ProjectController: UIViewController {
    var projectsArray = [ProjectList]()
    var projetUrlEndpoint = "Project/GetAll"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: projetUrlEndpoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [ProjectList]) in
            self.projectsArray = response
            self.tableView.reloadData()
        }
        
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ProjectController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        if let urlImage = projectsArray[indexPath.row].image, let url = URL(string: urlImage) {
            cell.projectImage.load(url: url)
        }
        cell.projetName.text = projectsArray[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard(name: "ProjectDetails", bundle: nil).instantiateViewController(identifier: "ProjectDetailsController")
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
