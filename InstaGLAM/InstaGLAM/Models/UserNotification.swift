//
//  UserNotification.swift
//  InstaGLAM
//
//  Created by omokagbo on 21/07/2021.
//

import Foundation

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let details: String
    let user: User
}
