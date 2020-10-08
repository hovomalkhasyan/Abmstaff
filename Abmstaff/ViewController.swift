//
//  ViewController.swift
//  Abmstaff
//
//  Created by Hovo on 10/1/20.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let urlEndpoint = "User/Login"
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login")!)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func signinAction(_ sender: UIButton) {
        if loginTF.text == "" || passwordTF.text == "" {
            showAlert()
        }else if CheckInternet.Connection() {
            let params : [String: Any] = [
                "login": loginTF.text!,
                "password": passwordTF.text!]
            
            NetWorkService.request(url: urlEndpoint, method: .post, param: params, encoding: JSONEncoding.default) { (response: DataClass) in
                print(response.token)
                UserDefaults.standard.setValue(response.token, forKey: "token")
                let newVC = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "navigation")
                UIApplication.shared.windows.first?.rootViewController = newVC
               
            }
        }else {
            let alertController = UIAlertController(title: "Your Device is not connected with internet", message: nil, preferredStyle: .alert)
            let alertAcion = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
                guard let url = URL(string: "App-prefs:root=WIFI") else {return}
                UIApplication.shared.open(url) { (result) in
                    if result {
                    }
                }
            }
            alertController.addAction(alertAcion)
            alertController.addAction(settingsAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Sign in Failed", message: "Please enter Email Address and Password", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
}
