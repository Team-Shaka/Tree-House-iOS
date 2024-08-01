//
//  PostCreateFeedPostsResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct PostCreateFeedPostsResponseDTO: Decodable {
    let postId: Int
    
    func toDomain() -> CreateFeedPostsResponseResponseEntity {
        return CreateFeedPostsResponseResponseEntity(postId: postId)
    }
}
