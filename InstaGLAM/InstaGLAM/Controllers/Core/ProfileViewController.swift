//
//  ProfileViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModel = ProfileViewModel()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        collectionView?.reloadData()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 1,
                                           bottom: 0,
                                           right: 1)
        let size = (view.width - 4) / 3
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView.register(ProfileInfoHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionView.register(ProfileTabsCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsBtn))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    @objc private func didTapSettingsBtn() {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings"
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
//        return viewModel.userPosts.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .white
        
//        cell.configure(with: viewModel.userPosts[indexPath.row])
        cell.setup(with: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            guard let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as? ProfileTabsCollectionReusableView else {
                return UICollectionReusableView()
            }
            tabControlHeader.delegate = self
            return tabControlHeader
        }
        
        guard let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as? ProfileInfoHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        profileHeader.delegate = self
        return profileHeader
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // get model and open posts controller
//        let viewController = PostDetailsViewController(model: viewModel.userPosts[indexPath.row])
        let viewController = PostDetailsViewController(model: nil)
        viewController.title = "Posts"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height / 3)
        }
        return CGSize(width: collectionView.width, height: 50)
    }
}

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    
    func didTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to posts section
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func didTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        
        var mockData = [UserRelationship]()
        for i in 0..<10 {
            mockData.append(UserRelationship(name: "Mary",
                                             username: "@marybisi",
                                             type: i % 2 == 0 ? .following : .notFollowing))
        }

        let viewController = ListViewController(models: mockData)
        viewController.title = "Followers"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        
        var mockData = [UserRelationship]()
        for i in 0..<10 {
            mockData.append(UserRelationship(name: "Mary",
                                             username: "@marybisi",
                                             type: i % 2 == 0 ? .following : .notFollowing))
        }
        
        let viewController = ListViewController(models: mockData)
        viewController.title = "Following"
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let viewController = EditProfileViewController()
        viewController.title = "Edit Profile"
        viewController.modalPresentationStyle = .fullScreen
        present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }
    
}

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    
    func didTapGridButton(_ header: ProfileTabsCollectionReusableView) {
            // reload collection view with data
    }
    
    func didTapTaggedButton(_ header: ProfileTabsCollectionReusableView) {
            // reload collection view with data
    }
    
}
