//
//  PatchUpdateFeedPostResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct PatchUpdateFeedPostResponseDTO: Decodable {
    let postId: Int
    
    func toDomain() -> UpdateFeedPostResponseEntity {
        return UpdateFeedPostResponseEntity(postId: postId)
    }
}
