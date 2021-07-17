//
//  PhotoPost.swift
//  InstaGLAM
//
//  Created by Decagon on 17/07/2021.
//

import Foundation

enum UserPostType {
    case photo, video
}

struct UserPost {
    let postType: UserPostType
}
