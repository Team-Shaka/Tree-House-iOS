//
//  GetCheckNotificationsResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct GetCheckNotificationsResponseDTO: Decodable {
    let notifications: [GetCheckNotificationsResponseData]
}

// MARK: -TODO (notificationsType)

struct GetCheckNotificationsResponseData: Decodable {
//    let type: notificationsType
    let profileImageUrl: String
    let userName: String
    let recievedTime: String
    let treehouseName: String
    let isChecked: Bool
    let targetId: Int
}

//enum notificationsType {
//
//}
