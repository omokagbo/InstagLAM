//
//  PostRenderViewModel.swift
//  InstaGLAM
//
//  Created by omokagbo on 22/07/2021.
//

import Foundation

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String) // like, comment, share buttons
    case comments(comments: [PostComment])
}

struct PostRenderViewModel {
    let renderType: PostRenderType
}
