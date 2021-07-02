//
//  LoginViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let userNameOrEmailTextField: UITextField = {
        return UITextField()
    }()
    
    private let passwordTextField: UITextField = {
        let field =  UITextField()
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginBtn: UIButton = {
        return UIButton()
    }()
    
    private let createAccountBtn: UIButton = {
        return UIButton()
    }()
    
    private let termsBtn: UIButton = {
        return UIButton()
    }()
    
    private let privacyBtn: UIButton = {
        return UIButton()
    }()
    
    private let headerView: UIView = {
        return UIView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        // assign frames
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
