//
//  PlatformsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/8/20.
//

import UIKit
import Alamofire

class PlatformsController: UIViewController {
    var platformArray = [Platforms]()
    var platformsApi = "Technology/GetAll"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: platformsApi, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [Platforms]) in
            self.platformArray = response
            self.tableView.reloadData()
        }
      
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension PlatformsController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platformArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlatformsCell", for: indexPath) as! PlatformsCell
        cell.name.text = platformArray[indexPath.row].name
        cell.count.text = String(platformArray[indexPath.row].membersCount)
        return cell
    }
    
}
