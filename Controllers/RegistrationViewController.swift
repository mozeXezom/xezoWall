//
//  ViewController.swift
//  xezoWallpapers
//
//  Created by mozeX on 21.09.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import SVProgressHUD

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.setTitleColor(.gray, for: .normal)
        registerButton.isEnabled = false
        
        handleTextField()
        textFieldDelegate()
        
        setupUI()
    }
    
    func setupUI() {
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.systemPink.cgColor
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.systemPink.cgColor
        nameTextField.layer.cornerRadius = 12
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.borderColor = UIColor.systemPink.cgColor
    }
    
    func validateFields() {
        
        //Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            SVProgressHUD.dismiss()
            showFieldAlert()
        }
        
        //Check if the password is secure
        let securedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Utilities.isPasswordValid(securedPassword) == false {
            //Password isn't secured
            SVProgressHUD.dismiss()
            showPasswordAlert()
        }
    }
    
    func showFieldAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill all fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        registerButton.shake()
        present(alert, animated: true)
    }
    
    func showPasswordAlert() {
        let alert = UIAlertController(title: "Error", message: "Password is not secured", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        registerButton.shake()
        present(alert, animated: true)
    }
    
    func showUserAlert() {
        let alert = UIAlertController(title: "Error", message: "Error creating the user", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        registerButton.shake()
        present(alert, animated: true)
    }
    
//    func createUser(withEmail email: String, password: String, username: String) {
//        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
//            if let error = error {
//                self.validateFields()
//                print("FAILED")
//                return
//            }
//
//            guard let uid = result?.user.uid else { return }
//
//            let values = ["email": email, "password": password, "username": self.nameTextField.text!]
//
//            Database.database().reference().child("users").child(uid).updateChildValues(values) { (error, ref) in
//                if let error = error {
//                    print("FAILED")
//                    return
//                }
//
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: Controllers.loginVC) as! LoginViewController
//                vc.modalPresentationStyle = .fullScreen
//                vc.modalTransitionStyle = .flipHorizontal
//                self.present(vc, animated: true, completion: nil)
//                print(result?.user.uid)
//                print("SUCCESS")
//            }
//        }
//    }
    
    func presentVC () {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Controllers.loginVC) as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        view.endEditing(true)
        
        SVProgressHUD.show(withStatus: "Creating your account...")
        validateFields()
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let username = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        DispatchQueue.global(qos: .background).async {
            AuthManager.shared.registerNewUser(username: username, email: email, password: password) { (registered) in
                DispatchQueue.main.async {
                    if registered {
                        print("SUCCESS")
                        SVProgressHUD.dismiss()
                        self.presentVC()
                    } else {
                        print("FAILED")
                        SVProgressHUD.dismiss()
                        //self.registerButton.shake()
                    }
                }
            }
        }
    }
}

//extension RegistrationViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == nameTextField {
//            emailTextField.becomeFirstResponder()
//        } else if textField == emailTextField {
//            passwordTextField.becomeFirstResponder()
//        } else {
//
//        }
//        return true
//    }
//}

extension RegistrationViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func handleTextField() {
        nameTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }

    func textFieldDelegate() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            nameTextField.becomeFirstResponder()
            return true
        case emailTextField:
            emailTextField.becomeFirstResponder()
            return true
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            return true
        default:
            break
        }
        return true
    }

    @objc func textFieldDidChange()  {
        guard let username = nameTextField.text,       !username.isEmpty,
            let email = emailTextField.text,             !email.isEmpty,
            let password = passwordTextField.text,       !password.isEmpty
            else {
                registerButton.setTitleColor(.gray, for: .normal)
                registerButton.isEnabled = false
                return
        }
        registerButton.isEnabled = true
        registerButton.setTitleColor(.white, for: .normal)
    }

}
