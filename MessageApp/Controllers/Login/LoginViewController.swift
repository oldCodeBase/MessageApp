//
//  LoginViewController.swift
//  MessageApp
//
//  Created by Ibragim Akaev on 11/01/2021.
//

import UIKit

class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField().customTextField
        field.placeholder = "Email Adress..."
        field.returnKeyType = .continue
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField().customTextField
        field.placeholder = "Password..."
        field.isSecureTextEntry = true
        field.returnKeyType = .done
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log In"
        view.backgroundColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButton.addTarget(self,
                               action: #selector(loginButtomTapped),
                               for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add subVies
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 2
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 50,
                                  y: imageView.buttom + 20,
                                  width: scrollView.width - 100,
                                  height: 46)
        passwordField.frame = CGRect(x: 50,
                                  y: emailField.buttom + 20,
                                  width: scrollView.width - 100,
                                  height: 46)
        loginButton.frame = CGRect(x: 70,
                                  y: passwordField.buttom + 20,
                                  width: scrollView.width - 140,
                                  height: 46)
    }
    
    @objc private func loginButtomTapped() {
        
        emailField.becomeFirstResponder()
        passwordField.becomeFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
                alertUserLoginError()
                return
        }
        //Firebase Log in
    }
    
    private func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to Log in",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButtomTapped()
        }
        return true
    }
}


