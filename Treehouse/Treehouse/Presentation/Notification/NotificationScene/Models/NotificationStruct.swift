//
//  NotificationStruct.swift
//  Treehouse
//
//  Created by 윤영서 on 4/19/24.
//

import Foundation
import SwiftUI

// TODO: - targetId 추가

struct NotificationStruct: Identifiable, Hashable {
    let id = UUID()
    let type: NotificationType
    let profileImageName: String
    let userName: String
    let time: String
    let tree: String
    let isChecked: Bool = false
    
    var profileImage: Image {
        Image(profileImageName)
    }
}

extension NotificationStruct {
    static let notificationDummyData: [NotificationStruct] = [
        NotificationStruct(type: .reactionToComment(emoji: "💛"),
                           profileImageName: "img_dumy",
                           userName: "useruser",
                           time: "30분전",
                           tree: "일산팟"),
        
        NotificationStruct(type: .replyOnComment,
                           profileImageName: "ic_noti_member",
                           userName: "tamama",
                           time: "45분전",
                           tree: "지디팟"),
        
        NotificationStruct(type: .reactionToPost(emoji: "🍄"),
                           profileImageName: "img_dummy_2",
                           userName: "whowhowhwo",
                           time: "5분전",
                           tree: "트리팟"),
        
        
        NotificationStruct(type: .replyOnComment,
                           profileImageName: "img_dumy",
                           userName: "tamama",
                           time: "45분전",
                           tree: "지디팟"),
        
        NotificationStruct(type: .inviteToTree,
                           profileImageName: "img_dummy_2",
                           userName: "whowhowhwo",
                           time: "5분전",
                           tree: "트리팟")
    ]
}
