//
//  GetReadMemberFeedResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct GetReadMemberFeedResponseDTO: Decodable {
    let memberProfile: MemberProfileResponseData
    let postList: [PostListResponseDTO]
}

struct PostListResponseDTO: Decodable {
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let commentCount: Int
    let reactionList: [ReactionListResponseData]
    let postedAt: String
}
