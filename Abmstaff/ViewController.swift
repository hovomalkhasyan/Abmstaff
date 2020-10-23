//
//  ViewController.swift
//  Abmstaff
//
//  Created by Hovo on 10/1/20.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    // MARK: - UrlEndpoints
    
    private let urlEndpoint = "User/Login"
    
    // MARK: - IBOutlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var signIn: UILabel!
    @IBOutlet weak var signInMessage: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var forgotPass: UIButton!
    @IBOutlet weak var passwordShowbtn: UIButton!
    
    // MARK: - ForgotPass
    
    private var iconClick = true
    private var signUp = true {
        willSet {
            if newValue {
                signIn.text = "FORGOT PASSWORD"
                signUpBtn.setTitle("Next", for: .normal)
                passwordTF.isHidden = true
                loginTF.text = ""
                signInMessage.text = "To reset your password type your email"
                forgotPass.setTitle("Sign In", for: .normal)
                passwordShowbtn.isHidden = true
            } else {
                signIn.text = "SIGN IN"
                passwordTF.text = ""
                loginTF.text = ""
                signUpBtn.setTitle("Sign In", for: .normal)
                passwordTF.isHidden = false
                signInMessage.text = "Sign in with your email"
                forgotPass.setTitle("Forgot password ?", for: .normal)
                passwordShowbtn.isHidden = false
            }
        }
    }
    // MARK: - Life Sycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        signUp = false
        setupTextFields()
        loginTF.delegate = self
        passwordTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNotifications()

    }
    
    private func setupTextFields() {
        loginTF.layer.cornerRadius = 15.0
        passwordTF.layer.cornerRadius = 15.0
        
    }
    
    // MARK: - KeyboardSettings
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame, from: nil).size.height
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height)
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: - SigninAction
    
    @IBAction func signinAction(_ sender: UIButton) {
        if CheckInternet.Connection() {
            self.view.endEditing(true)
            if signUp == false{
                if  loginTF.text == "" ||  passwordTF.text == "" {
                    showAlert(title: "Sign in Failed", message: "Please enter Email Address and Password")
                }else {
                    let params : [String: Any] = [
                        "login": loginTF.text!,
                        "password": passwordTF.text!]
                    
                    NetWorkService.request(url: urlEndpoint, method: .post, param: params, encoding: JSONEncoding.default) { (response: DataClass) in
                        print(response.token)
                        UserDefaults.standard.setValue(response.token, forKey: "token")
                        let newVC = UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "tab")
                        UIApplication.shared.windows.first?.rootViewController = newVC
                    }
                }
            } else {
                if loginTF.text == "" {
                    showAlert(title: "Email is empty", message: "Please enter your email")
                }else {
                    let codeStory = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "EnterCodeController")
                    navigationController?.pushViewController(codeStory, animated: true)
                }
            }
        } else {
            showConnectionAlert()
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        present(alert, animated: true, completion: nil)
    }
    
    private func showConnectionAlert() {
        let alertController = UIAlertController(title: "Your Device is not connected with internet" , message: nil, preferredStyle: .alert)
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
    
    // MARK: - IBActionforgotPassword
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        signUp = !signUp
    }
    
    // MARK: - IBActionshowPassword
    
    @IBAction func showPassword(_ sender: UIButton) {
        if(iconClick == true) {
            passwordTF.isSecureTextEntry = false
            passwordShowbtn.setImage(UIImage(named: "show"), for: .normal)
        } else {
            passwordTF.isSecureTextEntry = true
            passwordShowbtn.setImage(UIImage(named: "show1"), for: .normal)
        }
        
        iconClick = !iconClick
    }
    
}

// MARK: - TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTF:
            passwordTF.becomeFirstResponder()
        case passwordTF:
            UIView.animate(withDuration: 1) {
                self.view.endEditing(true)
            }
        default:
            break
        }
        
        return true
    }
    
}

