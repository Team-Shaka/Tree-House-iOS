//
//  ReadMemberFeedResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct ReadMemberFeedResponseEntity: Decodable, Identifiable {
    var id = UUID()
    let memberProfile: MemberProfileEntity
    let postList: [PostListResponseEntity]
}

struct PostListResponseEntity: Decodable, Identifiable {
    var id = UUID()
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let commentCount: Int
    let reactionList: ReactionListDataEntity
    let postedAt: String
}
