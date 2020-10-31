//
//  PartnerDetailsController.swift
//  Abmstaff
//
//  Created by Hovo on 10/15/20.
//

import UIKit
import Alamofire

class PartnerDetailsController: UIViewController {
    private var partnerDetailsApi = "Partner/Details/"
    private var partnerContact = "ContactPerson/GetAll/"
    var id = 0
    var partnerContacts = [PartnersContacts]()
    @IBOutlet weak var partnerLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var secondPhoneOutlet: UIButton!
    @IBOutlet weak var phoneBtnOutlet: UIButton!
    @IBOutlet weak var emailBtnOutlet: UIButton!
    @IBOutlet weak var partnersName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NetWorkService.request(url: partnerDetailsApi + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: PartnerDetails) in
            self.partnersName.text = response.companyName
            if let urlImage = response.logo, let url = URL(string: urlImage) {
                self.partnerLogo.sd_setImage(with: url)
            }
        }
        
        NetWorkService.request(url: partnerContact + String(id), method: .get, param: nil, encoding: JSONEncoding.default) { (response: [PartnersContacts]) in
            self.partnerContacts = response
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension PartnerDetailsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partnerContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.emailBtn.setTitle(partnerContacts[indexPath.row].email ?? "-", for: .normal)
        cell.phoneBtn.setTitle(partnerContacts[indexPath.row].phone ?? "-", for: .normal)
        cell.secondPhoneBtn.setTitle(partnerContacts[indexPath.row].secondPhone ?? "-", for: .normal)
        cell.personeName.text = partnerContacts[indexPath.row].fullName
        cell.phoneNumber = partnerContacts[indexPath.row].phone
        cell.secondPhone = partnerContacts[indexPath.row].secondPhone
        cell.email = partnerContacts[indexPath.row].email
        return cell
    }
    
    
}
