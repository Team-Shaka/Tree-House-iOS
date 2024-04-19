//
//  NotificationType.swift
//  Treehouse
//
//  Created by 윤영서 on 4/18/24.
//

import Foundation

enum NotificationType: Hashable {
    case replyOnPost
    case replyOnComment
    case reactionToPost(emoji: String)
    case reactionToComment(emoji: String)
    case inviteToTree
    
    var notificationContent: String {
        switch self {
        case .replyOnPost:
            return "님이 당신의 포스트에 댓글을 남겼습니다."
            
        case .replyOnComment:
            return "님이 당신의 댓글에 댓글을 남겼습니다."
            
        case .reactionToPost(let emoji):
            return "님이 당신의 포스트에 \(emoji)를 표시했습니다."
            
        case .reactionToComment(let emoji):
            return "님이 당신의 댓글에 \(emoji)를 표시했습니다."
            
        case .inviteToTree:
            return "님이 당신을 새로운 트리에 초대하였습니다."
        }
    }
}
