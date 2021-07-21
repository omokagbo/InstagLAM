//
//  ListViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class ListViewController: UIViewController {
    
    private var models = [UserRelationship]()
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        return table
    }()
    
    init(models: [UserRelationship]) {
        self.models = models
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as? UserFollowTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: models[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        // go to profile of selected cell
        
    }
}

extension ListViewController: UserFollowTableViewCellDelegate {
    
    func didTapFollowOrUnfollowBtn(with model: UserRelationship) {
        switch model.type {
        case .following:
            // update to unfollow
            print("successfully unfollowed")
            break
        case .notFollowing:
            // update to follow
            print("now following")
            break
        }
    }
    
}
