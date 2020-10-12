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
    @IBOutlet weak var demoView: Demo!
    @IBOutlet weak var signIn: UILabel!
    @IBOutlet weak var signInMessage: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPass: UIButton!
    var signUp = true {
        willSet {
            if newValue {
                signIn.text = "FORGOT PASSWORD"
                signUpBtn.setTitle("Next", for: .normal)
                passwordTF.isHidden = true
                signInMessage.text = "To reset your password type your email"
                forgotPass.setTitle("Sign In", for: .normal)
                
            } else {
                signIn.text = "Sing In"
                signUpBtn.setTitle("Sign In", for: .normal)
                passwordTF.isHidden = false
                signInMessage.text = "Sign in with your email"
                forgotPass.setTitle("Forgot password ?", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        signUp = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func signinAction(_ sender: UIButton) {
        if signUp == false {
            if loginTF.text == "" || passwordTF.text == "" {
                showAlert(title: "Sign in Failed", message: "Please enter Email Address and Password")
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
        } else {
            if loginTF.text == "" {
                showAlert(title: "Email is empty", message: "Please enter your email")
            }
        }
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func forgotPassword(_ sender: UIButton) {
        
        signUp = !signUp
    }
}
