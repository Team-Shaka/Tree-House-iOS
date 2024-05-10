//
//  NotificationModel.swift
//  Treehouse
//
//  Created by 윤영서 on 4/19/24.
//

import Foundation
import SwiftUI

// TODO: - targetId 추가

struct NotificationModel: Identifiable, Hashable {
    let id = UUID()
    let type: NotificationType
    let profileImageName: String
    let userName: String
    let time: String
    let tree: String
    let isChecked: Bool
    
    var profileImage: Image {
        Image(profileImageName)
    }
}

extension NotificationModel {
    static let notificationDummyData: [NotificationModel] = [
        NotificationModel(type: .reactionToComment(emoji: "💛"),
                           profileImageName: "img_dummy",
                           userName: "useruser",
                           time: "30분전",
                           tree: "일산팟", 
                           isChecked: false),
        
        NotificationModel(type: .replyOnComment,
                           profileImageName: "ic_noti_member",
                           userName: "tamama",
                           time: "45분전",
                           tree: "지디팟",
                           isChecked: true),
        
        NotificationModel(type: .reactionToPost(emoji: "🍄"),
                           profileImageName: "img_dummy_2",
                           userName: "whowhowhwo",
                           time: "5분전",
                           tree: "트리팟", 
                           isChecked: false),
        
        
        NotificationModel(type: .replyOnComment,
                           profileImageName: "img_dummy",
                           userName: "tamama",
                           time: "45분전",
                           tree: "지디팟", 
                           isChecked: true),
        
        NotificationModel(type: .inviteToTree,
                           profileImageName: "img_dummy_2",
                           userName: "whowhowhwo",
                           time: "5분전",
                           tree: "트리팟", 
                           isChecked: true),
        
        NotificationModel(type: .inviteToTree,
                           profileImageName: "img_dummy_2",
                           userName: "whowhowhwo",
                           time: "5분전",
                           tree: "트리팟",
                           isChecked: false)
    ]
}
