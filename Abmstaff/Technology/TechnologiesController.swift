//
//  TechnologiesController.swift
//  Abmstaff
//
//  Created by Hovo on 11/4/20.
//

import UIKit
import Alamofire

class TechnologiesController: UIViewController {
    private var technologiesEndPoind = "Technology/GetAll"
    var technologies = [Technologies]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: technologiesEndPoind, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [Technologies]) in
            self.technologies = response
            self.tableView.reloadData()
        }
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
