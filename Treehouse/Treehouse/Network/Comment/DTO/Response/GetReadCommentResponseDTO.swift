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
                                            reactionList: convertReactionListDataEntity($0.reactionList),
                                            commentId: $0.commentId,
                                            context: $0.context,
                                            replyList: convertReplyListEntity($0.replyList),
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
    
    private func convertReactionListDataEntity(_ data: ReactionListData) -> ReactionListDataEntity {
        return ReactionListDataEntity(reactionList: convertReactionListEntity(data.reactionList))
    }
    
    private func convertReactionListEntity(_ data: [ReactionListResponseData]) -> [ReactionListEntity] {
        var result = [ReactionListEntity]()
        
        data.forEach {
            result.append(ReactionListEntity(reactionName: $0.reactionName, reactionCount: $0.reactionCount, isPushed: $0.isPushed))
        }
         
        return result
    }
    
    private func convertReplyListEntity(_ data: [ReplyList]) -> [ReplyListEntity] {
        var result = [ReplyListEntity]()
        
        data.forEach {
            result.append(ReplyListEntity(memberProfile: convertMemberProfile($0.memberProfile),
                                          reactionList: convertReactionListDataEntity($0.reactionList),
                                          commentId: $0.commentId,
                                          context: $0.context,
                                          commentedAt: $0.commentedAt))
        }
        
        return result
    }
}

struct CommentList: Decodable {
    let memberProfile: MemberProfileResponseData
    let reactionList: ReactionListData
    let commentId: Int
    let context: String
    let replyList: [ReplyList]
    let commentedAt: String
}

struct ReplyList: Decodable {
    let memberProfile: MemberProfileResponseData
    let reactionList: ReactionListData
    let commentId: Int
    let context: String
    let commentedAt: String
}
