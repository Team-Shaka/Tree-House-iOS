//
//  ReadPostResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/22/24.
//

import Foundation

struct GetReadFeedPostListResponseEntity: Decodable, Identifiable {
    var id = UUID()
    let memberProfile: MemberProfileEntity
    let postId: Int
    var context: String
    let pictureUrlList: [String]
    let commentCount: Int
    var reactionList: ReactionListDataEntity
    let postedAt: String
}

struct ReactionListDataEntity: Identifiable, Decodable {
    var id = UUID()
    var reactionList: [ReactionListEntity]
}
