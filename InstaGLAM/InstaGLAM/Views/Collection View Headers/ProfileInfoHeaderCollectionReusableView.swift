//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstaGLAM
//
//  Created by omokagbo on 18/07/2021.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .systemBackground
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
