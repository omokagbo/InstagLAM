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
    
    // MARK:- FUNCTIONS TO MAKE CALLS TO FIREBASE
    func registerNewUser(fullName: String,
                         username: String,
                         email: String,
                         password: String) {
        
    }
    
    func loginUser(username: String?,
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
    
}
