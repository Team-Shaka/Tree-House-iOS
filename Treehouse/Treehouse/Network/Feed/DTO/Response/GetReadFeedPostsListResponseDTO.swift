//
//  GetReadFeedPostsListResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct GetReadFeedPostsListResponseDTO: Decodable {
    let memberProfile: MemberProfileResponseData
    let postId: Int
    let context: String
    let pictureUrlList: [String]
    let commentCount: Int
    let reactionList: ReactionListData
    let postedAt: String
    
    func toDomain() -> GetReadFeedPostListResponseEntity {
        return GetReadFeedPostListResponseEntity(memberProfile: convertMemberProfile(memberProfile),
                                                 postId: postId,
                                                 context: context,
                                                 pictureUrlList: pictureUrlList,
                                                 commentCount: commentCount, 
                                                 reactionList: convertReactionListDataEntity(reactionList),
                                                 postedAt: postedAt)
    }
    
    private func convertMemberProfile(_ data: MemberProfileResponseData) -> MemberProfileEntity {
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
}

struct MemberProfileResponseData: Decodable {
    let memberId: Int
    let memberName: String
    let memberProfileImageUrl: String?
    let memberBranch: Int
}

struct ReactionListData: Decodable {
    let reactionList: [ReactionListResponseData]
}

struct ReactionListResponseData: Decodable {
    let reactionName: String
    let reactionCount: Int
    let isPushed: Bool
}

