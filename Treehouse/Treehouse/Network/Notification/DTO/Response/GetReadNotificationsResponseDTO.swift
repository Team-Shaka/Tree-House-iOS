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
                NotificationResponseEntity(type: type ?? .comment,
                                           title: $0.title,
                                           body: $0.body,
                                           profileImageUrl: $0.profileImageUrl,
                                           userName: $0.userName,
                                           receivedTime: $0.receivedTime,
                                           treehouseId: $0.targetId,
                                           treehouseName: $0.treehouseName,
                                           isChecked: $0.isChecked,
                                           targetId: $0.targetId)
//                NotificationResponseEntity(type: $0.type, profileImageUrl: $0.profileImageUrl, userName: $0.userName, receivedTime: $0.receivedTime, treehouseName: $0.treehouseName, isChecked: $0.isChecked, targetId: $0.targetId)
            )
        }
        
        return result
    }
}

struct CheckNotificationResponseData: Decodable {
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

/*
"type": "POST_REACTION",
        "title": "게시글 반응 알림",
        "body": "테스트 하고 있습니다 님이 게시글에 😍을(를) 눌렀습니다.",
        "profileImageUrl": "https://tree-house-bucket.s3.ap-northeast-2.amazonaws.com/trees/239b3351-c814-4ff0-a423-74070bc8dddf12_PostImage",
        "userName": "테스트 하고 있습니다",
        "receivedTime": "1일 전",
        "treehouseId": 1,
        "treehouseName": "atree",
        "isChecked": false,
        "targetId": 11
*/
