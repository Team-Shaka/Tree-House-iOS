//
//  GetReadDetailFeedPostsResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct GetReadDetailFeedPostsResponseDTO: Decodable {
    let memberProfile: [MemberProfileResponseData]
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let reactionList: [ReactionListResponseData]
    let postedAt: String
}
