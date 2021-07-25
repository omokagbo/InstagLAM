//
//  ExploreViewController.swift
//  InstaGLAM
//
//  Created by omokagbo on 01/07/2021.
//

import UIKit

final class ExploreViewController: UIViewController {
    
    private var models = [UserPost]()
    
    private var collectionView: UICollectionView?
    
    private var tabbedSearchCollectionView: UICollectionView?
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundColor = .secondarySystemBackground
        search.placeholder = "Search"
        return search
    }()
    
    private let dimmedView: UIView = {
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black
        dimmedView.alpha = 0
        dimmedView.isHidden = true
        return dimmedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchBar()
        setupCollectionView()
        setupTabbedCollectionView()
        dimmedViewTapGesture()
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func dimmedViewTapGesture() {
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    
    private func setupTabbedCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width / 3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        tabbedSearchCollectionView?.backgroundColor = .systemIndigo
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
        }
        view.addSubview(tabbedSearchCollectionView)
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 4) / 3, height: (view.width - 4) / 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0,
                                                   y: view.safeAreaInsets.top,
                                                   width: view.width,
                                                   height: 72)
    }
    
    let post = UserPost(identifier: "13",
                        postType: .photo,
                        thumbnailImage: URL(string: "https://www.google.com")!,
                        postURL: URL(string: "https://www.google.com")!, caption: nil,
                        likeCount: [],
                        comments: [],
                        datePosted: Date(),
                        taggedUsers: [],
                        postOwner: User(username: "@ruth",
                                        bio: "Frontend engineer",
                                        name: (first: "", last: ""),
                                        birthDate: Date(),
                                        gender: .male,
                                        counts: .init(followers: 12, following: 34, posts: 44),
                                        dateJoined: Date(),
                                        profilePhoto: URL(string: "https://www.google.com")!))
    
}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tabbedSearchCollectionView {
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        //        cell.configure(with: )
        cell.setup(with: "test")
        return cell
    }
}

extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewController = PostDetailsViewController(model: post)
        viewController.title = post.postType.rawValue
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ExploreViewController: UISearchBarDelegate {
    
    private func query(_ text: String) {
        // perform the search in the back end
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        if let content = searchBar.text, !content.isEmpty, content != "" {
            query(content)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didCancelSearch))
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0.4
        } completion: { done in
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
        
    }
    
    @objc private func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        tabbedSearchCollectionView?.isHidden = true
        dimmedView.isHidden = true
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dimmedView.isHidden = true
        }
    }
    
}
