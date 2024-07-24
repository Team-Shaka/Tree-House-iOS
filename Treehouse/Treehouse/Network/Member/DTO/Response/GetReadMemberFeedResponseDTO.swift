//
//  GetReadMemberFeedResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct GetReadMemberFeedResponseDTO: Decodable {
    let memberProfile: MemberProfileResponseData
    let postList: [PostListResponseDTO]
    
    func toDomain() -> ReadMemberFeedResponseEntity {
        return ReadMemberFeedResponseEntity(memberProfile: convertMemberProfile(memberProfile), 
                                            postList: convertPostList(postList))
    }
    
    private func convertMemberProfile(_ data: MemberProfileResponseData) -> MemberProfileEntity {
        return MemberProfileEntity(memberId: data.memberId,
                                   memberName: data.memberName,
                                   memberProfileImageUrl: data.memberProfileImageUrl,
                                   memberBranch: data.memberBranch)
    }
    
    private func convertPostList(_ data: [PostListResponseDTO]) -> [PostListResponseEntity] {
        var result = [PostListResponseEntity]()
        
        data.forEach {
            result.append(PostListResponseEntity(postId: $0.postId,
                                   context: $0.context,
                                   pictureUrlList: $0.pictureUrlList,
                                   commentCount: $0.commentCount,
                                   reactionList: convertReactionListEntity($0.reactionList),
                                   postedAt: $0.postedAt)
            )
        }
        
        return result
    }
    
    private func convertReactionListEntity(_ data: [ReactionListResponseData]) -> [ReactionListEntity] {
        var result = [ReactionListEntity]()
        
        data.forEach {
            result.append(ReactionListEntity(reactionName: $0.reactionName, 
                                             reactionCount: $0.reactionCount,
                                             isPushed: $0.isPushed)
            )
        }
         
        return result
    }
    
}

struct PostListResponseDTO: Decodable {
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let commentCount: Int
    let reactionList: [ReactionListResponseData]
    let postedAt: String
}
