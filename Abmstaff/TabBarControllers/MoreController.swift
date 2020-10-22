//
//  MoreController.swift
//  Abmstaff
//
//  Created by Hovo on 10/22/20.
//

import UIKit

class MoreController: UIViewController {
    var array = ["About us", "Positions", "Technologies", "Settings"]
    var btnArray = ["Staff", "Projects", "Team", "Partners"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    private func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
extension MoreController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as! MoreCell
        cell.moreLbl.text = array[indexPath.row]
        
        return cell
    }
    
}

extension MoreController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionCell", for: indexPath) as! MoreCollectionCell
        cell.btnName.text = btnArray[indexPath.row]
        cell.view.layer.borderWidth = 0.3
        cell.view.layer.borderColor = UIColor.lightGray.cgColor
        cell.view.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard(name: "Staff", bundle: nil).instantiateViewController(identifier: "StaffController") as! StaffController
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "Project", bundle: nil).instantiateViewController(identifier: "ProjectController") as! ProjectController
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = UIStoryboard(name: "Staff", bundle: nil).instantiateViewController(identifier: "TeamViewController") as! TeamViewController
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = UIStoryboard(name: "Partners", bundle: nil).instantiateViewController(identifier: "PartnersController") as! PartnersController
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}