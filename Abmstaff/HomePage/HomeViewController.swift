//
//  HomeViewController.swift
//  Abmstaff
//
//  Created by Hovo on 10/13/20.
//

import UIKit
@IBDesignable
class HomeViewController: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView()
    }
    
    func stackView() {
        for view in stack.subviews {
            view.layer.shadowColor = UIColor.gray.cgColor
            view.layer.shadowRadius = 5
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = .zero
            view.layer.cornerRadius = 10
        }
    }

}
