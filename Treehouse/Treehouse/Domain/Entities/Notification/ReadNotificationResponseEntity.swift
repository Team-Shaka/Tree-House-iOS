//
//  CheckNotificationResponseEntity.swift
//  Treehouse
//
//  Created by 윤영서 on 7/10/24.
//

import Foundation

struct ReadNotificationResponseEntity: Decodable, Identifiable {
    var id = UUID()
    let notifications: [NotificationResponseEntity]
}

struct NotificationResponseEntity: Decodable, Identifiable {
    var id = UUID()
    let notificationId: Int
    let type: NotificationTypeEnum
    let title: String
    let body: String
    let profileImageUrl: String?
    let userName: String
    let receivedTime: String
    let treehouseId: Int
    let treehouseName: String
    var isChecked: Bool
    let targetId: Int
}

enum NotificationTypeEnum: Decodable {
    case invitation
    case comment
    case reply
    case postReaction
    case commentReaction
    
    var notificationContent: String {
        switch self {
        case .invitation:
            return "님이 당신을 새로운 트릐에 초대하였습니다."
            
        case .comment:
            return "님이 당신의 포스트에 댓글을 남겼습니다."
            
        case .reply:
            return "님이 당신의 댓글에 댓글을 남겼습니다."
            
        case .postReaction:
            return "님이 당신의 포스트에 emoji를 표시했습니다."
            
        case .commentReaction:
            return "님이 당신의 댓글에 emoji를 표시했습니다."
        }
    }
}
