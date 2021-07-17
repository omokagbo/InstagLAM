//
//  SignUpViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit
import SafariServices

final class SignUpViewController: UIViewController {
    
    enum SignupError: Error {
        case missingUsername
        case missingEmail
        case invalidEmail
        case missingPassword
        case invalidPassword
    }
    
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
        button.backgroundColor = .systemGreen
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
        registerBtn.addTarget(self, action: #selector(didTapRegisterBtn), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
        addSubViews()
    }
    
    override func viewDidLayoutSubviews() {
        // assign frames
        super.viewDidLayoutSubviews()
        usernameTextField.frame = CGRect(x: 25.0,
                                         y: view.safeAreaInsets.top + 50.0,
                                         width: view.right - 50.0,
                                         height: Constants.textFieldsHeight)
        emailTextField.frame = CGRect(x: 25.0,
                                      y: usernameTextField.bottom + 10.0,
                                      width: view.right - 50.0,
                                      height: Constants.textFieldsHeight)
        passwordTextField.frame = CGRect(x: 25.0,
                                         y: emailTextField.bottom + 10.0,
                                         width: view.right - 50.0,
                                         height: Constants.textFieldsHeight)
        registerBtn.frame = CGRect(x: 25.0,
                                   y: passwordTextField.bottom + 30.0,
                                   width: view.right - 50.0,
                                   height: Constants.buttonHeight)
        loginBtn.frame = CGRect(x: 25.0,
                                y: registerBtn.bottom + 10.0,
                                width: view.right - 50.0,
                                height: Constants.buttonHeight)
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
        view.addSubview(loginBtn)
        view.addSubview(termsBtn)
        view.addSubview(privacyBtn)
    }
    
    @objc private func didTapRegisterBtn() {
        do {
            try validateFields()
            registerNewUser()
        } catch SignupError.missingUsername {
            self.showAlert(alertText: "Username Empty", alertMessage: "You need a username to create an account.")
        } catch SignupError.missingEmail {
            self.showAlert(alertText: "Email Empty", alertMessage: "You need an email to create an account.")
        } catch SignupError.invalidEmail {
            self.showAlert(alertText: "Invalid Email", alertMessage: "Please, enter in a valid email.")
        } catch SignupError.missingPassword {
            self.showAlert(alertText: "Password Empty", alertMessage: "Please enter in your password.")
        } catch SignupError.invalidPassword {
            self.showAlert(alertText: "Invalid Password",
                           alertMessage: "Your password must be alphanumeric and it must be greater than or equal to 8 characters.")
        } catch {
            self.showAlert(alertText: "An Error Occured", alertMessage: "Unable to create an account. Please try again.")
        }
    }
    
    private func registerNewUser() {
        // implement signup
        if let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
                DispatchQueue.main.async {
                    if registered {
                        
                    } else {
                        
                    }
                }
            }
        }
    }
    
    @objc private func didTapLoginBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyBtn() {
        self.privacyPolicy()
    }
    
    @objc private func didTapTermsBtn() {
        self.termsOfService()
    }
    
    func validateFields() throws {
        guard let username = usernameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if username.isEmpty || username == "" {
            throw SignupError.missingUsername
        }
        if email.isEmpty || username == "" {
            throw SignupError.missingEmail
        }
        if !email.isValidEmail {
            throw SignupError.invalidEmail
        }
        if password.isEmpty || password == "" {
            throw SignupError.missingPassword
        }
        if !password.isValidPassword {
            throw SignupError.invalidPassword
        }
    }
}
