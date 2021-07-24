//
//  FeedHeaderTableViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 17/07/2021.
//

import UIKit

protocol FeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton(sender: FeedPostHeaderTableViewCell)
}

class FeedPostHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostHeaderTableViewCell"
    
    weak var delegate: FeedPostHeaderTableViewCellDelegate?
    
    private let profilePhotoImage: UIImageView = {
        let profilePhoto = UIImageView()
        profilePhoto.layer.masksToBounds = true
        profilePhoto.clipsToBounds = true
        profilePhoto.contentMode = .scaleAspectFill
        return profilePhoto
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profilePhotoImage)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    private func configureSubviews() {
        let size = contentView.height - 4
        profilePhotoImage.frame = CGRect(x: 2,
                                         y: 2,
                                         width: size,
                                         height: size)
        profilePhotoImage.layer.cornerRadius = size / 2
        
        moreButton.frame = CGRect(x: contentView.width - size,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        usernameLabel.frame = CGRect(x: profilePhotoImage.right + 10,
                                     y: 2,
                                     width: contentView.width - (size * 2) - 15,
                                     height: contentView.height - 4)
    }
    
    public func configure(with model: User) {
        usernameLabel.text = model.username
        //        profilePhotoImage.sd_setImage(with: model.profilePhoto, completed: nil)
        profilePhotoImage.image = UIImage(named: "test")
        
    }
    
    @objc private func didTapMoreButton() {
        delegate?.didTapMoreButton(sender: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImage.image = nil
    }
}
