//
//  EnterCodeController.swift
//  Abmstaff
//
//  Created by Hovo on 10/12/20.
//

import UIKit

class EnterCodeController: UIViewController {

    @IBOutlet weak var numberOne: UITextField!
    @IBOutlet weak var numberTwo: UITextField!
    @IBOutlet weak var numberThree: UITextField!
    @IBOutlet weak var numberFour: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
    
    }

    @IBAction func nextButton(_ sender: UIButton) {
    }
}
