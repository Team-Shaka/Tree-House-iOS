//
//  GetReadCommentResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct GetReadCommentResponseDTO: Decodable {
    let commentList: [CommentList]?
    func toDomain() -> ReadCommentResponseEntity {
        var result = [CommentListEntity]()
        
        commentList?.forEach {
            result.append(CommentListEntity(memberProfile: convertMemberProfile($0.memberProfile),
                                            reactionList: convertReactionList($0.reactionList),
                                            commentId: $0.commentId,
                                            context: $0.context,
                                            replyList: convertReplyList($0.replyList),
                                            commentedAt: $0.commentedAt))
        }
        
        return ReadCommentResponseEntity(commentList: result)
    }
    
    func convertMemberProfile(_ data: MemberProfileResponseData) -> MemberProfileEntity {
        return MemberProfileEntity(memberId: data.memberId,
                                   memberName: data.memberName,
                                   memberProfileImageUrl: data.memberProfileImageUrl,
                                   memberBranch: data.memberBranch)
    }
    
    func convertReactionList(_ data: [ReactionListResponseData]?) -> [ReactionListEntity] {
        if let data = data {
            return data.map {
                return ReactionListEntity(reactionName: $0.reactionName,
                                          reactionCount: $0.reactionCount,
                                          isPushed: $0.isPushed)
            }
        } else {
            return []
        }
    }
    
    func convertReplyList(_ data: [ReplyList]? ) -> [ReplyListEntity] {
        if let data = data {
            return data.map {
                return ReplyListEntity(memberProfile: convertMemberProfile($0.memberProfile),
                                       reactionList: convertReactionList($0.reactionList),
                                       commentId: $0.commentId,
                                       context: $0.context,
                                       commentedAt: $0.commentedAt)
            }
        } else {
            return []
        }
    }
}

struct CommentList: Identifiable, Decodable {
    var id = UUID()
    let memberProfile: MemberProfileResponseData
    let reactionList: [ReactionListResponseData]?
    let commentId: Int
    let context: String
    let replyList: [ReplyList]?
    let commentedAt: String
}

struct ReplyList: Identifiable, Decodable {
    var id = UUID()
    let memberProfile: MemberProfileResponseData
    let reactionList: [ReactionListResponseData]
    let commentId: Int
    let context: String
    let commentedAt: String
}
