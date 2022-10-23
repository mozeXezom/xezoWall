//
//  LoginViewController.swift
//  xezoWallpapers
//
//  Created by mozeX on 23.09.2022.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var signUpButtonLabel: UIButton!
    @IBOutlet weak var loginButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFielsdDelegate()
        loginButtonLabel.isEnabled = false
        handleTextFields()
        setupUI()
        
    }
    
    func setupUI() {
        loginTextField.layer.cornerRadius = 12
        loginTextField.layer.borderWidth = 2
        loginTextField.layer.borderColor = UIColor.systemPink.cgColor
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.systemPink.cgColor
        
        loginLabel.textColor = UIColor(patternImage: UIImage(named: "gradient")!)
        passwordLabel.textColor = UIColor(patternImage: UIImage(named: "gradient")!)
    }
    
    func showLoginAlert() {
        let alert = UIAlertController(title: "Error", message: "Wrong email or password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        loginButtonLabel.shake()
        present(alert, animated: true)
    }
    
    func presentVC() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        view.endEditing(true)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: "Signing in...")
        
        let email = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        AuthManager.loginWith(email: email, password: password, onSuccess: { [unowned self] in
            SVProgressHUD.dismiss()
            print("SUCCESS LOGGED IN")
            presentVC()
        }, onError: { error in
            SVProgressHUD.showError(withStatus: error!)
            self.loginButtonLabel.shake()
        })
    
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Controllers.registrationVC) as! RegistrationViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func handleTextFields() {
        loginTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    func textFielsdDelegate() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func textFieldDidChange() {
        guard let email = loginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
            else {
                loginButtonLabel.setTitleColor(.gray, for: .normal)
            loginButtonLabel.isEnabled = false
                return
            }
        loginButtonLabel.isEnabled = true
        loginButtonLabel.setTitleColor(.white, for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            passwordTextField.becomeFirstResponder()
            return true
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            return true
        default:
            break
        }
        return true
    }
    
}
