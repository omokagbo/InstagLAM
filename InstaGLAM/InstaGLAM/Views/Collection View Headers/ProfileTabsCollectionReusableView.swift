//
//  ProfileTabsCollectionReusableView.swift
//  InstaGLAM
//
//  Created by omokagbo on 18/07/2021.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButton(_ header: ProfileTabsCollectionReusableView)
    func didTapTaggedButton(_ header: ProfileTabsCollectionReusableView)
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        addSubview(gridButton)
        addSubview(taggedButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = height - 20
        let gridButtonHorizontal = ((width / 2) - size) / 2
        gridButton.frame = CGRect(x: gridButtonHorizontal,
                                  y: 4,
                                  width: size,
                                  height: size).integral
        
        taggedButton.frame = CGRect(x: gridButtonHorizontal + (width / 2),
                                    y: 4,
                                    width: size,
                                    height: size).integral
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .systemGray
        gridButton.setBackgroundImage(UIImage(systemName: "square.grid.2x2.fill"), for: .normal)
        delegate?.didTapGridButton(self)
    }
    
    @objc private func didTapTaggedButton() {
        gridButton.tintColor = .systemGray
        taggedButton.tintColor = .systemBlue
        taggedButton.setBackgroundImage(UIImage(systemName: "tag.fill"), for: .normal)
        delegate?.didTapTaggedButton(self)
    }
    
}
