//
//  ProjectController.swift
//  Abmstaff
//
//  Created by Hovo on 10/7/20.
//

import UIKit
import Alamofire

class ProjectController: UIViewController {
    
    private var projectsArray = [ProjectList]()
    private let projetUrlEndpoint = "Project/GetAll"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getProjectList()
        setupNavigation()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationIsHidden()
        
    }
    
    private func getProjectList() {
        
        NetWorkService.request(url: projetUrlEndpoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [ProjectList]) in
            self.projectsArray = response
            self.tableView.reloadData()
        }
        
    }
    
    private func setupNavigation() {
        self.title = "Projects"
        
    }
    
    private func navigationIsHidden() {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
        
    }
    
}

extension ProjectController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        if let urlImage = projectsArray[indexPath.row].image, let url = URL(string: urlImage) {
            cell.projectImage.sd_setImage(with: url)
        }
        
        cell.projetName.text = projectsArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard(name: "ProjectDetails", bundle: nil).instantiateViewController(identifier: "ProjectDetailsController") as! ProjectDetailsController
        detailsVC.id = projectsArray[indexPath.row].id
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
