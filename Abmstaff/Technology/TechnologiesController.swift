//
//  TechnologiesController.swift
//  Abmstaff
//
//  Created by Hovo on 11/4/20.
//

import UIKit
import Alamofire

class TechnologiesController: UIViewController {
    
    private let technologiesEndPoind = "Technology/GetAll"
    private var technologies = [Technologies]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getTechnologies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    private func getTechnologies() {
        
        NetWorkService.request(url: technologiesEndPoind, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [Technologies]) in
            self.technologies = response
            self.tableView.reloadData()
        }
        
    }
    
}

extension TechnologiesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return technologies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TechnologiesCell", for: indexPath) as! TechnologiesCell
        cell.technoCount.text = String(technologies[indexPath.row].membersCount)
        cell.technoName.text = technologies[indexPath.row].name
        return cell
        
    }
    
}
