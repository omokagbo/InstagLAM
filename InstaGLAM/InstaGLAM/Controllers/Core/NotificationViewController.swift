//
//  NotificationViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class NotificationViewController: UIViewController {
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = false
        table.separatorStyle = .none
        table.register(NotificationLikeEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        table.register(NotificationFollowEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return table
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private var models = [UserNotification]()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        //        setupSpinner()
        view.addSubview(noNotificationsView)
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    // MARK: - Methods
    
    private func addNoNotificationsView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 2)
        noNotificationsView.center = view.center
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func fetchNotifications() {
        let user = User(username: "@ruth",
                        bio: "Frontend engineer",
                        name: (first: "", last: ""),
                        birthDate: Date(),
                        gender: .male,
                        counts: .init(followers: 12, following: 34, posts: 44),
                        dateJoined: Date(),
                        profilePhoto: URL(string: "https://www.google.com")!)
        
        let post = UserPost(identifier: "13",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!, caption: nil,
                            likeCount: [],
                            comments: [],
                            datePosted: Date(),
                            taggedUsers: [])
        
        for i in 0..<100{
            
            let model = UserNotification(type: i % 2 == 0 ? .follow(state: .following) : .like(post: post),
                                         details: i % 2 == 0 ? "@bro just followed you" : "@mat liked your new post",
                                         user: user)
            models.append(model)
        }
    }
}

extension NotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
        
        switch model.type {
        case .like(post: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as? NotificationLikeEventTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(with: model)
            return cell
        case .follow:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as? NotificationFollowEventTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configure(with: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}

extension NotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NotificationViewController: NotificationFollowEventTableViewCellDelegate {
    
    func didTapFollowOrUnfollowBtn(model: UserNotification) {
        print("follow or unfollow")
        // perform database update
    }
    
}

extension NotificationViewController: NotificationLikeEventTableViewCellDelegate {
    
    func didTapRelatePostsBtn(model: UserNotification) {
        print("tapped post")
        // perform database update
    }
    
}
