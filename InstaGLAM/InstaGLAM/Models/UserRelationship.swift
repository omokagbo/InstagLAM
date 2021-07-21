//
//  UserFollowState.swift
//  InstaGLAM
//
//  Created by omokagbo on 21/07/2021.
//

import Foundation

enum FollowState {
    case following, notFollowing
}

struct UserRelationship {
    let name: String
    let username: String
    let type: FollowState
}
