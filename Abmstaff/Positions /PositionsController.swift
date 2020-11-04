//
//  PositionsController.swift
//  Abmstaff
//
//  Created by Hovo on 11/4/20.
//

import UIKit
import Alamofire

class PositionsController: UIViewController {
    var positionsArray = [Position]()
    var positionEndPoint = "Position/GetAll"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: positionEndPoint, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [Position]) in
            self.positionsArray = response
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Position"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 10
    }

}
extension PositionsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PositionsCell", for: indexPath) as! PositionsCell
        cell.positionName.text = positionsArray[indexPath.row].name
        cell.positionCount.text = String(positionsArray[indexPath.row].membersCount)
        return cell
    }
    
    
}
