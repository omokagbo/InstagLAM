//
//  AuthManager.swift
//  InstaGLAM
//
//  Created by omokagbo on 02/07/2021.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    private init(){}
    
    // MARK: - FUNCTIONS TO MAKE CALLS TO FIREBASE
    
    public func registerNewUser(username: String,
                                email: String,
                                password: String,
                                completion: @escaping (Bool) -> Void) {
        /*
         - check if username is available
         - check if email is available
         */
        DatabaseManager.shared.canCreateNewUser(email: email, username: username) { canCreate in
            if canCreate {
                // create account
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    // insert into database
                    DatabaseManager.shared.insertNewUser(email: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
            }
        }
    }
    
    /// Allows users to login
    /// - Parameters:
    ///   - username: Username entered by the user
    ///   - email: Email entered by the user
    ///   - password: Password entered by the user
    ///   - completion: completion to show if the user logs in successfully
    public func loginUser(username: String?,
                          email: String?,
                          password: String,
                          completion: @escaping ((Bool) -> Void)) {
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }   else if let username = username {
            // username login
            print(username)
        }
    }
    
    /// Log out user from app
    /// - Parameter completion: completion to show if the user successfully logs out
    public func logout(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            debugPrint(error)
            completion(false)
            return
        }
    }
    
}
