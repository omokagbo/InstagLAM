//
//  SettingsViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let viewModel: SettingsViewModel = SettingsViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        table.separatorStyle = .none
        table.register(UITableViewCell.self, forCellReuseIdentifier:  "cell")
        return table
    }()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        viewModel.data.append([
            SettingsModel(title: "Edit Profile", handler: { [weak self] in
            self?.didTapEditProfile()
        }),
            SettingsModel(title: "Invite Friends", handler: { [weak self] in
            self?.didTapInviteFriends()
        }),
            SettingsModel(title: "Save Original Posts", handler: { [weak self] in
            self?.didTapSaveOriginalPosts()
        })
        ])
        
        viewModel.data.append([
            SettingsModel(title: "Terms of Service", handler: { [weak self] in
            self?.didTapTermsOfService()
        }),
            SettingsModel(title: "Privacy Policy", handler: { [weak self] in
            self?.didTapPrivacyPolicy()
        }),
            SettingsModel(title: "Help/Feedback", handler: { [weak self] in
            self?.didTapHelpOrFeedback()
        })
        ])
        
        viewModel.data.append([
            SettingsModel(title: "Log Out", handler: { [weak self] in
            self?.didTapLogOut()
        })
        ])
    }
    
    private func didTapEditProfile() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.title = "Edit Profile"
        let navigationController = UINavigationController(rootViewController: editProfileViewController)
        present(navigationController, animated: true)
    }
    
    private func didTapInviteFriends() {
        // share sheet to invite profile
    }
    
    private func didTapSaveOriginalPosts() {}
    
    private func didTapTermsOfService() {
        self.termsOfService()
    }
    
    private func didTapPrivacyPolicy() {
        self.privacyPolicy()
    }
    
    private func didTapHelpOrFeedback() {
        self.helpOrFeedback()
    }
    
    
    private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        actionSheet
            .addAction(UIAlertAction(title: "Cancel",
                                     style: .cancel, handler: nil))
        actionSheet
            .addAction(UIAlertAction(title: "Yes",
                                     style: .destructive, handler: { _ in
                AuthManager.shared.logout { loggedOut in
                    DispatchQueue.main.async {
                        if loggedOut {
                            // present log in screen
                            self.presentLogIn()
                            self.tabBarController?.selectedIndex = 0
                        } else {
                            // throw error
                            self.showAlert(alertText: "Log out unsuccessful", alertMessage: "Unable to log out. Please try again.")
                        }
                    }
                }
            }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func presentLogIn() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.modalTransitionStyle = .crossDissolve
        present(loginViewController, animated: true) {
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // configure cell here
        cell.textLabel?.text = viewModel.data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selection
        viewModel.data[indexPath.section][indexPath.row].handler()
    }
}
