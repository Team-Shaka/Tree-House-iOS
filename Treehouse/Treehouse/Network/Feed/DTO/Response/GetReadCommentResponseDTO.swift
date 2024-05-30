//
//  GetReadCommentResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct GetReadCommentResponseDTO: Decodable {
    let memberProfile: [MemberProfileResponseData]
    let reactionList: [ReactionListResponseData]
    let commentId: Int
    let context: String
    let commentedAt: String
}
