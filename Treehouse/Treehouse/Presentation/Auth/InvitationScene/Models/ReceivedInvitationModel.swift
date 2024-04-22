//
//  ReceivedInvitationModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/20/24.
//

import Foundation
import SwiftUI

struct ReceivedInvitationModel: Identifiable, Hashable {
    let id = UUID()
    
    let invitatiedId: Int = 0
    var treehouseName: String
    var senderName: String = "Chriiii0o0"
    var senderProfileImageUrl: String
    var treehouseCount: Int
    
    var groupImage: Image {
        Image(senderProfileImageUrl) // 이미지 이름을 사용하여 Image를 생성
    }
}
