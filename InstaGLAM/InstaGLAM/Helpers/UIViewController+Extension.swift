//
//  UIViewController+Extension.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit
import SafariServices

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func showAlert (alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.backButtonTitle = " "
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    func navigateToHome() {
        let newStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = newStoryboard
                .instantiateViewController(identifier: "HomeTabBarNav") as UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
    static func instantiate(storyboardName: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
    func presentLogin() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.modalTransitionStyle = .crossDissolve
        present(loginViewController, animated: true)
    }
    
    func privacyPolicy() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875?helpref=page_content") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
    
    func termsOfService() {
        guard let url = URL(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/#:~:text=Basic%20Terms&text=You%20may%20not%20post%20nude,or%20intimidate%20other%20Instagram%20users.") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
    
    func helpOrFeedback() {
        guard let url = URL(string: "https://help.instagram.com/") else { return }
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
    
}

