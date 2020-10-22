//
//  HomePageController.swift
//  Abmstaff
//
//  Created by Hovo on 10/22/20.
//

import UIKit

enum SectionType: Int,CaseIterable {
    case favoriteProjects
    case recently
    case teamsProject
    
    func getIcon() -> UIImage {
        switch self {
        case .favoriteProjects:
            return UIImage(named: "time")!
        case.recently:
            return UIImage(named: "time")!
        case.teamsProject:
            return UIImage(named: "time")!
        }
        
    }
    
    func getTitle() -> String {
        switch self {
        case .favoriteProjects:
            return "Favorite Projects"
        case .recently:
            return "Recently Viewd Projects"
        case .teamsProject:
            return "#1 Teams Projects"
        }
    }
}

class HomePageController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 20
    }
}

extension HomePageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = SectionType(rawValue: indexPath.section)
        switch sectionType {
        case .teamsProject:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTeam", for: indexPath) as! ProjectTeam
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = SectionType(rawValue: section)
        let header = tableView.dequeueReusableCell(withIdentifier: "Header") as! Header
        header.iconeImage.image = sectionType?.getIcon()
        header.titleOfHeader.text = sectionType?.getTitle()
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableCell(withIdentifier: "Footer") as! Footer
        
        return footer
    }
    
}
