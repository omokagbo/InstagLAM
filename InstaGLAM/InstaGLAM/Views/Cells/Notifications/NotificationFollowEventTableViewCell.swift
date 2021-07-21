//
//  NotificationFollowEventTableViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 21/07/2021.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowOrUnfollowBtn(model: UserNotification)
}

final class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    private var model: UserNotification?
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.backgroundColor = .systemGray3
        return profileImage
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@sam followed you"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
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
        followButton.addTarget(self, action: #selector(didTapFollowBtn), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    private func setupSubviews() {
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        
        profileImageView.layer.cornerRadius = height / 2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton .frame = CGRect(x: contentView.width - 5 - size,
                                     y: (contentView.height - buttonHeight) / 2,
                                     width: size,
                                     height: buttonHeight)
        
        detailsLabel.frame = CGRect(x: profileImageView.right + 5,
                                    y: 0,
                                    width: contentView.width - size - profileImageView.width - 16,
                                    height: contentView.height)
    }
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(followButton)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        detailsLabel.text = nil
        profileImageView.image = nil
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        detailsLabel.text = model.details
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        
        switch model.type {
        case .like(post: _):
            break
        case .follow(let state):
            switch state {
            case .following:
                followButton.setTitle("Unfollow", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
            case .notFollowing:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
            }
        }
    }
    
    @objc private func didTapFollowBtn() {
        if let model = model {
            delegate?.didTapFollowOrUnfollowBtn(model: model)
        }
    }
    
}
