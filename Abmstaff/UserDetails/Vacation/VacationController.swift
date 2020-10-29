//
//  VacationController.swift
//  Abmstaff
//
//  Created by Hovo on 10/26/20.
//

import UIKit

enum VacationSectionType: Int,CaseIterable {
    case currentYear
    case vacationHistory
    
    
    func getIcon() -> UIImage {
        switch self {
        case .currentYear:
            return UIImage(named: "calendar")!
        case.vacationHistory:
            return UIImage(named: "time")!
        }
        
    }
    
    func getTitle() -> String {
        switch self {
        case .currentYear:
            return "Current Year"
        case .vacationHistory:
            return "Vacation History"
        }
    }
}

class VacationController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTableView()
        
    }
//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
}

//extension VacationController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       return UITableViewCell
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let VacationSectionType = SectionType(rawValue: section)
//        let header = tableView.dequeueReusableCell(withIdentifier: "VacationHeader") as! VacationHeader
//
//        header.headerImage.image = VacationSectionType?.getIcon()
//        header.headerLbl.text = VacationSectionType?.getTitle()
//
//        return header
//    }
//
//}
