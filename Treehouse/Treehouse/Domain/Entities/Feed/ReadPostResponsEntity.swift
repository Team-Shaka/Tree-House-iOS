//
//  ReadPostResponsEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/22/24.
//

import Foundation

struct GetReadFeedPostListResponseEntity: Decodable, Identifiable {
    var id = UUID()
    let memberProfile: MemberProfileEntity
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let reactionList: ReactionListDataEntity
    let postedAt: String
}

struct ReactionListDataEntity: Decodable {
    let reactionList: [ReactionListEntity]
}
