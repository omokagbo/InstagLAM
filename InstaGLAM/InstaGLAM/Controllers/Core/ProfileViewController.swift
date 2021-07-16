//
//  ProfileViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear.circle"),
                                                           style: .done,
                                                           target: self,
                                                            action: #selector(didTapSettingsBtn))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc private func didTapSettingsBtn() {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings"
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
