//
//  GetReadFeedPostsListResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct GetReadFeedPostsListResponseDTO: Decodable {
    let memberProfile: [MemberProfileResponseData]
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let reactionList: [ReactionListResponseData]
    let postedAt: String
}

struct MemberProfileResponseData: Decodable {
    let memberId: Int
    let memberName: String
    let memberProfileImageUrl: String
    let memberBranch: Int
}

struct ReactionListResponseData: Decodable {
    let reactionName: String
    let reactionCount: Int
    let isPushed: Bool
}
