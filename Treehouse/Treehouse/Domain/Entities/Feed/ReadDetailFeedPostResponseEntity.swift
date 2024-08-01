//
//  ReadDetailFeedPostResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/26/24.
//

import Foundation

struct GetReadDetailFeedPostResponseEntity: Decodable, Identifiable {
    var id = UUID()
    let memberProfile: MemberProfileEntity
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let commentCount: Int
    var reactionList: ReactionListDataEntity
    let postedAt: String
}
