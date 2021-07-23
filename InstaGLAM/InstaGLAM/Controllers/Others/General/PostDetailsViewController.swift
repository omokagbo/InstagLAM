//
//  PostDetailsViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class PostDetailsViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        table.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        table.register(FeedPostActionTableViewCell.self, forCellReuseIdentifier: FeedPostActionTableViewCell.identifier)
        table.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
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
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureModels() {
        guard let model = model else {
            return
        }
        
        // header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: model.postOwner)))
        
        // post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: model)))
        
        // actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "Emar")))
        
        // comments
        var comments = [PostComment]()
        for _ in 0..<4 {
            comments.append(PostComment(identifier: "",
                                        username: "@tris343",
                                        text: "You look good",
                                        datePosted: Date(),
                                        likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments))
        )
    }
    
}

extension PostDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .header(provider: _):
            return 1
        case .primaryContent(provider: _):
            return 1
        case .actions(provider: _):
            return 1
        case .comments(comments: let comments):
            return comments.count > 4 ? 4 : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch renderModels[indexPath.section].renderType {
        case .header(provider: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier, for: indexPath) as? FeedPostHeaderTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case .primaryContent(provider: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier, for: indexPath) as? FeedPostTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case .actions(provider: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionTableViewCell.identifier, for: indexPath) as? FeedPostActionTableViewCell else {
                return UITableViewCell()
            }
            return cell
            
        case .comments(comments: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifier, for: indexPath) as? FeedPostGeneralTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch renderModels[indexPath.section].renderType {
        case .header(provider: _):  return 70
        case .primaryContent(provider: _):  return tableView.width
        case .actions(provider: _): return 60
        case .comments(comments: _):  return 50
        }
    }
}

extension PostDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
