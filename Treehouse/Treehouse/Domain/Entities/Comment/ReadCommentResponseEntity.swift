//
//  ReadCommentResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

struct ReadCommentResponseEntity: Identifiable, Decodable {
    var id = UUID()
    let commentList: [CommentListEntity]?
}

struct CommentListEntity: Identifiable, Decodable {
    var id = UUID()
    let memberProfile: MemberProfileEntity
    let reactionList: [ReactionListEntity]?
    let commentId: Int
    let context: String
    let replyList: [ReplyListEntity]?
    let commentedAt: String
}

struct ReplyListEntity: Identifiable, Decodable {
    var id = UUID()
    let memberProfile: MemberProfileEntity
    let reactionList: [ReactionListEntity]
    let commentId: Int
    let context: String
    let commentedAt: String
}

struct MemberProfileEntity: Identifiable, Decodable {
    var id = UUID()
    let memberId: Int
    let memberName: String
    let memberProfileImageUrl: String
    let memberBranch: Int
}

struct ReactionListEntity: Identifiable, Decodable {
    var id = UUID()
    let reactionName: String
    let reactionCount: Int
    var isPushed: Bool
}
