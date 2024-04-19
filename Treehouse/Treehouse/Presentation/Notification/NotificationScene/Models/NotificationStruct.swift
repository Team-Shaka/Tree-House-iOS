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
