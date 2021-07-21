//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstaGLAM
//
//  Created by omokagbo on 18/07/2021.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func didTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func didTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func didTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func didTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.backgroundColor = .systemBlue
        profilePhoto.image = UIImage(named: "test")
        profilePhoto.layer.masksToBounds = true
        return profilePhoto
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
//        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
//        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
//        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
//        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "Emmanuel Omokagbo"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "💻 Software Engineer at Decagon."
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        configureSubviews()
        addButtonsActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profilePhotoSize = width / 4
        let buttonHeight = profilePhotoSize / 2
        let buttonWidth = (width - 10 - profilePhotoSize) / 3
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2
        
        postButton.frame = CGRect(x: profilePhotoImageView.right,
                                  y: 5,
                                  width: buttonWidth,
                                  height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postButton.right,
                                       y: 5,
                                       width: buttonWidth,
                                       height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.right,
                                       y: 5,
                                       width: buttonWidth,
                                       height: buttonHeight).integral
        
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                       y: 5 + buttonHeight,
                                       width: buttonWidth * 3,
                                       height: buttonHeight).integral
        
        nameLabel.frame = CGRect(x: 10,
                                 y: 5 + profilePhotoImageView.bottom,
                                 width: width - 10,
                                 height: 50)
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        
        bioLabel.frame = CGRect(x: 10,
                                y: 5 + nameLabel.bottom,
                                 width: width - 10,
                                height: bioLabelSize.height)
    }
    
    private func configureSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    func addButtonsActions() {
        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    @objc private func didTapPostsButton () {
        delegate?.didTapPostsButton(self)
    }
    
    @objc private func didTapFollowersButton () {
        delegate?.didTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton () {
        delegate?.didTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton () {
        delegate?.didTapEditProfileButton(self)
    }
}
