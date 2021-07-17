//
//  StorageManager.swift
//  InstaGLAM
//
//  Created by omokagbo on 02/07/2021.
//

import Foundation
import FirebaseStorage


class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    private let bucket = Storage.storage().reference()
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageManagerError.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }
}

enum StorageManagerError: Error {
    case failedToDownload
}
