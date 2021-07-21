//
//  UserFollowTableViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 21/07/2021.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowOrUnfollowBtn(with model: UserRelationship)
}

class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    
    private var model: UserRelationship?
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Mary Bisi"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@marybisi"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height -  6,
                                        height: contentView.height - 6)
        
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3
        
        followButton.frame = CGRect(x:  contentView.width - 5 - buttonWidth,
                                    y: 17.5,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height / 2
        let labelWidth = contentView.width - 8 - profileImageView.width -  buttonWidth
        
        nameLabel.frame = CGRect(x: profileImageView.right + 5,
                                 y: 0,
                                 width: labelWidth,
                                 height: labelHeight)
        
        usernameLabel.frame = CGRect(x: profileImageView.right + 5,
                                     y: nameLabel.bottom,
                                     width: labelWidth,
                                     height: labelHeight)
        
    }
    
    @objc private func didTapFollowButton() {
        if let model = model {
            delegate?.didTapFollowOrUnfollowBtn(with: model)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .secondarySystemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.systemGray6.cgColor
        case .notFollowing:
            // show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
}
