//
//  PostCreateReplyCommentResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/28/24.
//

import Foundation

struct PostCreateReplyCommentResponseDTO: Decodable {
    let commentId: Int
    
    func toDomain() -> CreateCommentResponseEntity {
        return CreateCommentResponseEntity(commentId: commentId)
    }
}
