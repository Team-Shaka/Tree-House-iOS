//
//  ReadMemberFeedResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct ReadMemberFeedResponseEntity: Decodable {
    let memberProfile: MemberProfileResponseData
    let postList: [PostListResponseEntity]
}

struct PostListResponseEntity: Decodable {
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let commentCount: Int
    let reactionList: [ReactionListEntity]
    let postedAt: String
}
