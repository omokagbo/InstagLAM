//
//  PhotoCollectionViewCell.swift
//  InstaGLAM
//
//  Created by omokagbo on 18/07/2021.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    
     let photoImageView: UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds //CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double tap to open posts"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        photoImageView.sd_setImage(with: model.thumbnailImage, completed: nil)
    }
    
    public func setup(with imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }
}
