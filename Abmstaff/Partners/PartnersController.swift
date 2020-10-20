//
//  PartnersController.swift
//  Abmstaff
//
//  Created by Hovo on 10/15/20.
//

import UIKit
import Alamofire
class PartnersController: UIViewController {
    private var partners = [Partners]()
    private let partnersApi = "Partner/GetAll"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: partnersApi, method: .get, param: nil, encoding: JSONEncoding.default) { (response: [Partners]) in
            self.partners = response
            self.tableView.reloadData()
        }
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension PartnersController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartnersCell", for: indexPath) as! PartnersCell
        cell.partnerName.text = partners[indexPath.row].companyName
        if let urlImage = partners[indexPath.row].logo, let url = URL(string: urlImage) {
            cell.partnersAvatar.load(url: url)
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = UIStoryboard(name: "PartnerDetails", bundle: nil).instantiateViewController(identifier: "PartnerDetailsController") as! PartnerDetailsController
        detailsVC.id = partners[indexPath.row].id
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
