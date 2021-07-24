//
//  FeedPostActionTableViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 17/07/2021.
//

import UIKit

protocol FeedPostActionTableViewCellDelegate: AnyObject {
    func didTapLikeButton(sender: FeedPostActionTableViewCell)
    func didTapCommentButton(sender: FeedPostActionTableViewCell)
    func didTapSendButton(sender: FeedPostActionTableViewCell)
}

class FeedPostActionTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostActionTableViewCell"
    
    weak var delegate: FeedPostActionTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(commentButton)
        likeButton.addTarget(self, action: #selector(didTapLikeBtn), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendBtn), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentBtn), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = contentView.height - 10
        let buttons = [likeButton, commentButton, sendButton]
        for i in 0..<buttons.count {
            buttons[i].frame = CGRect(x: (CGFloat(i) * buttonSize) + (10 * CGFloat(i + 1)),
                                      y: 5,
                                      width: buttonSize,
                                      height: buttonSize)
        }
    }
    
    @objc private func didTapLikeBtn() {
        delegate?.didTapLikeButton(sender: self)
    }
    
    @objc private func didTapCommentBtn() {
        delegate?.didTapCommentButton(sender: self)
    }
    
    @objc private func didTapSendBtn() {
        delegate?.didTapSendButton(sender: self)
    }
    
    public func cofigure(with post: UserPost) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
