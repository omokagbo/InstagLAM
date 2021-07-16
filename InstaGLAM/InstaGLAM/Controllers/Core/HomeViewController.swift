//
//  ViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit
import FirebaseAuth

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        handleAuthentication()
    }
    
    private func handleAuthentication() {
        // check auth status
        if Auth.auth().currentUser == nil {
            // show login
//            let loginViewController = LoginViewController()
//            loginViewController.modalPresentationStyle = .fullScreen
//            loginViewController.modalTransitionStyle = .crossDissolve
//            present(loginViewController, animated: true)
            presentLogin()
        }
    }
}

