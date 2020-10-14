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
        for v in stack.subviews {
            v.layer.shadowColor = UIColor.gray.cgColor
            v.layer.shadowRadius = 5
            v.layer.shadowOpacity = 1
            v.layer.shadowOffset = .zero
            v.layer.cornerRadius = 10
        }
    }

}
