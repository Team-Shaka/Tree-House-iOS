//
//  GetCheckNotificationsResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct GetReadNotificationsResponseDTO: Decodable {
    let notifications: [CheckNotificationResponseData]
    
    func toDomain() -> ReadNotificationResponseEntity {
        return ReadNotificationResponseEntity(notifications: convertNotification(notifications))
    }
    
    private func convertNotification(_ data: [CheckNotificationResponseData]) -> [NotificationResponseEntity] {
        var result = [NotificationResponseEntity]()
        
        data.forEach {
            var type: NotificationTypeEnum?
            switch $0.type {
            case "COMMENT":
                type = .comment
            case "POST_REACTION":
                type = .postReaction
            case "REPLY":
                type = .reply
            case "INVITATION":
                type = .invitation
            case "COMMENT_REACTION":
                type = .commentReaction
            default:
                break
            }
            
            result.append(
                NotificationResponseEntity(notificationId: $0.notificationId,
                                           type: type ?? .comment,
                                           title: $0.title,
                                           body: $0.body,
                                           profileImageUrl: $0.profileImageUrl,
                                           userName: $0.userName,
                                           receivedTime: $0.receivedTime,
                                           treehouseId: $0.targetId,
                                           treehouseName: $0.treehouseName,
                                           isChecked: $0.isChecked,
                                           targetId: $0.targetId)
            )
        }
        
        return result
    }
}

struct CheckNotificationResponseData: Decodable {
    let notificationId: Int
    let type: String
    let title: String
    let body: String
    let profileImageUrl: String?
    let userName: String
    let receivedTime: String
    let treehouseId: Int
    let treehouseName: String
    let isChecked: Bool
    let targetId: Int
}
