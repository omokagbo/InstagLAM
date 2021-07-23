//
//  HomeViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit
import FirebaseAuth

final class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        table.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        table.register(FeedPostActionTableViewCell.self, forCellReuseIdentifier: FeedPostActionTableViewCell.identifier)
        table.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        createMockModels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        handleAuthentication()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: -  Methods
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func handleAuthentication() {
        // check auth status
        if Auth.auth().currentUser == nil {
            // show login
            presentLogin()
        }
    }
    
    private func createMockModels() {
        
        let user = User(username: "@ruth",
                        bio: "Frontend engineer",
                        name: (first: "", last: ""),
                        birthDate: Date(),
                        gender: .male,
                        counts: .init(followers: 12, following: 34, posts: 44),
                        dateJoined: Date(),
                        profilePhoto: URL(string: "https://www.google.com")!)
        
        let newPost = UserPost(identifier: "13",
                               postType: .photo,
                               thumbnailImage: URL(string: "https://www.google.com")!,
                               postURL: URL(string: "https://www.google.com")!, caption: nil,
                               likeCount: [],
                               comments: [],
                               datePosted: Date(),
                               taggedUsers: [],
                               postOwner: user)
        
        var comments = [PostComment]()
        for x in 0...5 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "@babie",
                                        text: "You look great fam",
                                        datePosted: Date(),
                                        likes: []))
        }
        
        let header = PostRenderViewModel(renderType: .header(provider: user))
        let post = PostRenderViewModel(renderType: .primaryContent(provider: newPost))
        let action = PostRenderViewModel(renderType: .actions(provider: "Hello"))
        let comment = PostRenderViewModel(renderType: .comments(comments: comments))
        
        for _ in 0...5 {
            let viewModel = HomeFeedRenderViewModel(header: header,
                                                    post: post,
                                                    actions: action,
                                                    comments: comment)
            feedRenderModels.append(viewModel)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let model: HomeFeedRenderViewModel
        if section == 0 {
            model = feedRenderModels[0]
        } else {
            let position = section % 4 == 0 ? section / 4 : ((section - (section % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        if section % 4 == 0 {
            // header
            return 1
        } else if section % 4 == 1 {
            // post
            return 1
        } else if section % 4 == 2 {
            // actions
            return 1
        } else if section % 4 == 3 {
            // comments
            switch model.comments.renderType {
            case .comments(comments: let comments): return comments.count > 2 ? 2 : comments.count
            case .header(provider: _): break
            case .primaryContent(provider: _): break
            case .actions(provider: _): break
            }
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: HomeFeedRenderViewModel
        let x = indexPath.section
        if indexPath.section == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        if x % 4 == 0 {
            // header
            switch model.header.renderType {
            case .header(provider: _):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier, for: indexPath) as? FeedPostHeaderTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            case .primaryContent(_): break
            case .actions(_): break
            case .comments(_): break
            }
        } else if x % 4 == 1 {
            // post
            switch model.post.renderType {
            case .header(_): break
            case .primaryContent(provider: _):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier, for: indexPath) as? FeedPostTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            case .actions(_): break
            case .comments(_): break
            }
        } else if x % 4 == 2 {
            // actions
            switch model.actions.renderType {
            case .header(_): break
            case .primaryContent(_): break
            case .actions(provider: _):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionTableViewCell.identifier, for: indexPath) as? FeedPostActionTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            case .comments(_): break
            }
        } else if x % 4 == 3 {
            // comments
            switch model.comments.renderType {
            case .header(provider: _): break
            case .primaryContent(provider: _): break
            case .actions(provider: _): break
            case .comments(comments: _):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifier, for: indexPath) as? FeedPostGeneralTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section % 4 == 0 {
            return 70
        } else if indexPath.section % 4 == 1 {
            return tableView.width
        } else if indexPath.section % 4 == 2 {
            return 60
        } else if indexPath.section % 4 == 3 {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section % 4 == 3 ? 40 : 0
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
