//
//  noNotificationsView.swift
//  InstaGLAM
//
//  Created by omokagbo on 21/07/2021.
//

import UIKit

class NoNotificationsView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "No Notifications Yet"
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height - 50).integral
        imageView.frame = CGRect(x: (width - 50) / 2, y: 0, width: 50, height: 50).integral
        
    }
    
}
