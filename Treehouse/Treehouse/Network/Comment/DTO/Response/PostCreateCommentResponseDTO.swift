//
//  PostCreateCommentResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct PostCreateCommentResponseDTO: Decodable {
    let commentId: Int
    
    func toDomain() -> CreateCommentResponseEntity {
        return CreateCommentResponseEntity(commentId: commentId)
    }
}
