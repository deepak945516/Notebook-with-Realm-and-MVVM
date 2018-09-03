//
//  LoginViewController.swift
//  RealmTest
//
//  Created by Deepak Kumar on 31/08/18.
//  Copyright © 2018 Deepak Kumar. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    // MARK: - Private Methods
    private func initialSetup() {
        passwordTextField.becomeFirstResponder()
        loginButton.layer.cornerRadius = passwordTextField.frame.size.height / 2
        loginButton.dropShadow(shadowRadius: 10)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set("0000", forKey: "password")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }

    // MARK: - IBAction Methods
    @IBAction private func showHidePasswordButtonTapped(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }

    @IBAction private func setResetPasswordButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController.init(title: "Notebook", message: "New user? Old password is '0000'", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Old Password"
            textField.textAlignment = .center
        }
        alertController.addTextField { textField in
            textField.placeholder = "New Password"
            textField.textAlignment = .center
            textField.isSecureTextEntry = true
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            guard let oldPasswordField = alertController?.textFields?[0], let newPasswordField = alertController?.textFields?[1]  else { return }
            guard let savedPassword = UserDefaults.standard.value(forKey: "password") as? String else { return }
            print(savedPassword)
            if oldPasswordField.text! ==  savedPassword {
                UserDefaults.standard.set(newPasswordField.text!, forKey: "password")
            } else {
                let message = NSAttributedString(string: "Wrong password!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
                alertController?.setValue(message, forKey: "attributedMessage")
                self.present(alertController!, animated: true, completion: nil)
            }
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)

    }

    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        guard let savedPassword = UserDefaults.standard.value(forKey: "password") as? String else { return }
        if passwordTextField.text! == savedPassword {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            if let taskListViewController = mainStoryBoard.instantiateViewController(withIdentifier: "TaskListViewController") as? TaskListViewController {
                passwordTextField.text = ""
                self.navigationController?.pushViewController(taskListViewController, animated: true)
            }
        } else {
            let alertController = UIAlertController.init(title: "Notebook", message: "Please enter correct password", preferredStyle: .alert)
            let okButton = UIAlertAction.init(title: "OK", style: .default) { okButton in
            }
            alertController.addAction(okButton)
            let message = NSAttributedString(string: "Please enter correct password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
            alertController.setValue(message, forKey: "attributedMessage")
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - TextField Delegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
