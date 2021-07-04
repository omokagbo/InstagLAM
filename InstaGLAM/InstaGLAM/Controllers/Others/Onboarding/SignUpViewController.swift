//
//  SignUpViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit
import SafariServices

class SignUpViewController: UIViewController {
    
    private let usernameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.textFieldsCornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailTextField: UITextField = {
        let field =  UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Email"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.textFieldsCornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordTextField: UITextField = {
        let field =  UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.textFieldsCornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.cornerRadius = Constants.buttonCornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Already have an account? Log in", for: .normal)
        button.layer.masksToBounds = true
        button.cornerRadius = Constants.buttonCornerRadius
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let termsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    private let privacyBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        // assign frames
        super.viewDidLayoutSubviews()
        usernameTextField.frame = CGRect(x: 25.0,
                                         y: view.safeAreaInsets.top + 20.0,
                                         width: view.right - 50.0,
                                         height: Constants.textFieldsHeight)
        emailTextField.frame = CGRect(x: 25.0,
                                      y: usernameTextField.bottom + 20.0,
                                      width: view.right - 50.0,
                                      height: Constants.textFieldsHeight)
        passwordTextField.frame = CGRect(x: 25.0,
                                         y: emailTextField.bottom + 20.0,
                                         width: view.right - 50.0,
                                         height: Constants.textFieldsHeight)
        registerBtn.frame = CGRect(x: 25.0,
                                   y: passwordTextField.bottom + 40.0,
                                   width: view.right - 50.0,
                                   height: Constants.buttonHeight)
//        loginBtn.frame = CGRect(x: <#T##CGFloat#>,
//                                y: <#T##CGFloat#>,
//                                width: <#T##CGFloat#>,
//                                height: <#T##CGFloat#>)
        termsBtn.frame = CGRect(x: 25.0,
                                y: view.bottom - 100.0,
                                width: view.width - 50.0,
                                height: Constants.buttonHeight)
        privacyBtn.frame = CGRect(x: 25.0,
                                  y: view.bottom - 70.0,
                                  width: view.width - 50,
                                  height: Constants.buttonHeight)
    }
    
    private func addSubViews() {
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerBtn)
    }

}
