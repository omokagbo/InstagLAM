//
//  NotificationLikeEventTableViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 21/07/2021.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatePostsBtn(model: UserNotification)
}

final class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    private var model: UserNotification?
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let profileImage = UIImageView()
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.image = UIImage(named: "test")
        profileImage.backgroundColor = .systemGray3
        return profileImage
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@Emar just liked your new post"
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostBtn), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
    }
    
    @objc private func didTapPostBtn() {
        if let model = model {
            delegate?.didTapRelatePostsBtn(model: model)
        }
    }
    
    private func setupSubviews() {
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        
        profileImageView.layer.cornerRadius = height / 2
        
        let size = contentView.height - 4
        postButton.frame = CGRect(x: contentView.width - 5 - size, y: 2, width: size, height: size)
        
        detailsLabel.frame = CGRect(x: profileImageView.right + 5,
                                    y: 0,
                                    width: contentView.width - size - profileImageView.width - 16,
                                    height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        detailsLabel.text = nil
        profileImageView.image = nil
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        detailsLabel.text = model.details
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        
        switch model.type {
        case .like(post: let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setImage(with: thumbnail, for: .normal, completed: nil)
            print(post)
        case .follow:
            break
        }
    }
    
}
