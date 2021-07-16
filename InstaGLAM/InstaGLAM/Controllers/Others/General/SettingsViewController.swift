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
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier:  "cell")
        return table
    }()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        let section = [SettingsModel(title: "Log Out", handler: { [weak self] in
            guard let self = self else {
                return
            }
            self.didTapLogOut()
        })]
        viewModel.data.append(section)
    }
    
    private func didTapLogOut() {
        AuthManager.shared.logout { loggedOut in
            DispatchQueue.main.async {
                if loggedOut {
                    // log user out
                    let loginViewController = LoginViewController()
                    loginViewController.modalPresentationStyle = .fullScreen
                    loginViewController.modalTransitionStyle = .crossDissolve
                    self.present(loginViewController, animated: true) {
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                } else {
                    // throw error
                    
                }
            }
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
