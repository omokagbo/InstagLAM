//
//  DatabaseManager.swift
//  InstaGLAM
//
//  Created by omokagbo on 02/07/2021.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private init(){}
    
    private let database = Database.database().reference()
    
    /// Check if username and email are available
    /// - Parameters:
    ///   - email: email entered by the user
    ///   - username: username entered by the user
    ///   - completion: completion to show if the username and email are available
    func canCreateNewUser(email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Inserts new user data into database
    /// - Parameters:
    ///   - email: email entered by the user
    ///   - username: username entered by the user
    ///   - completion: completion to show if the user has been successfully added to the database
    func insertNewUser(email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDataBaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                // succeeds
                completion(true)
                return
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
    
    // MARK: -
    
    private func safeKey() {
        
    }
    
}
