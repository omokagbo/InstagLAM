//
//  PhotoPost.swift
//  InstaGLAM
//
//  Created by omokagbo on 17/07/2021.
//

import Foundation

/// enum showing the different types of  post a user can make
enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

/// enum showing genders
enum Gender {
    case male, female, other
}

/// struct describing a user
struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCounts
    let dateJoined: Date
    let profilePhoto: URL
}


/// struct describing the followers, following and post count of a user
struct UserCounts {
    let followers: Int
    let following: Int
    let posts: Int
}

/// struct describing the posts a user makes
struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution phot
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let datePosted: Date
    let taggedUsers: [String]
    let postOwner: User
}

/// struct showing details of the likes on a post
struct PostLikes {
    let username: String
    let postIdentifier: String
}

/// struct showing the details of the comments on a post
struct CommentLikes {
    let username: String
    let commentIdentifier: String
}


/// struct describing the comments on a post
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let datePosted: Date
    let likes: [CommentLikes]
}



