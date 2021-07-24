//
//  FeedPostTableViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 17/07/2021.
//

import UIKit
import SDWebImage
import AVFoundation

final class FeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostTableViewCell"
    
    let post = UserPost(identifier: "13",
                        postType: .photo,
                        thumbnailImage: URL(string: "https://www.google.com")!,
                        postURL: URL(string: "https://www.google.com")!, caption: nil,
                        likeCount: [],
                        comments: [],
                        datePosted: Date(),
                        taggedUsers: [],
                        postOwner: User(username: "@ruth",
                                        bio: "Frontend engineer",
                                        name: (first: "", last: ""),
                                        birthDate: Date(),
                                        gender: .male,
                                        counts: .init(followers: 12, following: 34, posts: 44),
                                        dateJoined: Date(),
                                        profilePhoto: URL(string: "https://www.google.com")!))
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    private let postImageView: UIImageView = {
        let postImage = UIImageView()
        postImage.contentMode = .scaleAspectFill
        postImage.backgroundColor = nil
        postImage.clipsToBounds = true
        return postImage
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
        configure(with: post)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        
//        switch post.postType {
//        case .photo:
//            postImageView.sd_setImage(with: post.postURL, completed: nil)
//        case .video:
//            player = AVPlayer(url: post.postURL)
//            playerLayer.player = player
//            playerLayer.player?.volume = 0
//            playerLayer.player?.play()
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
}
