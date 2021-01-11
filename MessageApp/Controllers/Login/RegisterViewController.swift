//
//  RegisterViewController.swift
//  MessageApp
//
//  Created by Ibragim Akaev on 11/01/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField().customTextField
        field.placeholder = "First name..."
        field.returnKeyType = .next
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField().customTextField
        field.placeholder = "Last name..."
        field.returnKeyType = .next
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField().customTextField
        field.placeholder = "Email Adress..."
        field.returnKeyType = .next
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField().customTextField
        field.placeholder = "Password..."
        field.returnKeyType = .done
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
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
        
        registerButton.addTarget(self,
                               action: #selector(registerButtomTapped),
                               for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add subVies
        view.addSubview(scrollView)

        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(gesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        firstNameField.frame = CGRect(x: 50,
                                  y: imageView.buttom + 20,
                                  width: scrollView.width - 100,
                                  height: 46)
        
        lastNameField.frame = CGRect(x: 50,
                                  y: firstNameField.buttom + 20,
                                  width: scrollView.width - 100,
                                  height: 46)
        
        emailField.frame = CGRect(x: 50,
                                  y: lastNameField.buttom + 20,
                                  width: scrollView.width - 100,
                                  height: 46)
        
        passwordField.frame = CGRect(x: 50,
                                  y: emailField.buttom + 20,
                                  width: scrollView.width - 100,
                                  height: 46)
        
        registerButton.frame = CGRect(x: 70,
                                  y: passwordField.buttom + 40,
                                  width: scrollView.width - 140,
                                  height: 46)
    }
    
    @objc private func didTapChangeProfilePic() {
        print("Change profile pic tapped")
    }
    
    @objc private func registerButtomTapped() {
        
        firstNameField.becomeFirstResponder()
        lastNameField.becomeFirstResponder()
        emailField.becomeFirstResponder()
        passwordField.becomeFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              let firstName = firstNameField.text, let lastName = lastNameField.text,
              !email.isEmpty, !password.isEmpty, !firstName.isEmpty, !lastName.isEmpty,
              password.count >= 6 else {
                alertUserLoginError()
                return
        }
        //Firebase Log in
    }
    
    private func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to create a new account",
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtomTapped()
        }
        return true
    }
}
