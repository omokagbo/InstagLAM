//
//  LoginViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {
    
    private let userNameOrEmailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email"
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
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.cornerRadius = Constants.buttonCornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let createAccountBtn: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create Account", for: .normal)
        button.layer.masksToBounds = true
        button.cornerRadius = Constants.buttonCornerRadius
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let termsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Terms & Conditions", for: .normal)
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
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "Gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        // assign frames
        headerView.frame = CGRect(x: 0.0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0)
        userNameOrEmailTextField.frame = CGRect(x: 25.0,
                                                y: headerView.bottom + 40.0,
                                                width: view.width - 50.0,
                                                height: Constants.textFieldsHeight)
        passwordTextField.frame = CGRect(x: 25.0,
                                         y: userNameOrEmailTextField.bottom + 20.0,
                                         width: view.width - 50.0,
                                         height: Constants.textFieldsHeight)
        loginBtn.frame = CGRect(x: 25.0,
                                y: passwordTextField.bottom + 20.0,
                                width: view.width - 50.0,
                                height: Constants.buttonHeight)
        createAccountBtn.frame = CGRect(x: 25.0,
                                        y: loginBtn.bottom + 10.0,
                                        width: view.width - 50.0,
                                        height: Constants.buttonHeight)
        termsBtn.frame = CGRect(x: 25.0,
                                y: view.bottom - 100.0,
                                width: view.width - 50.0,
                                height: Constants.buttonHeight)
        privacyBtn.frame = CGRect(x: 25.0,
                                  y: view.bottom - 70.0,
                                  width: view.width - 50,
                                  height: Constants.buttonHeight)
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        // add instagram logo
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews() {
        view.addSubview(userNameOrEmailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginBtn)
        view.addSubview(createAccountBtn)
        view.addSubview(termsBtn)
        view.addSubview(privacyBtn)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginBtn() {
        
    }
    
    @objc private func didTapCreateAccount() {
        
    }
    
    @objc private func didTapPrivacyBtn() {
        
    }
    
    @objc private func didTapTermsBtn() {
        
    }
    
}
