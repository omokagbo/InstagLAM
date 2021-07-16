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
        let section = [SettingsModel(title: "Log Out", handler: { [weak self] in
            self?.didTapLogOut()
        })]
        viewModel.data.append(section)
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
//            self.tabBarController?.selectedIndex = 0
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
