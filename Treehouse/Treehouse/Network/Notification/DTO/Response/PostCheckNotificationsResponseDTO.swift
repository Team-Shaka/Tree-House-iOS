//
//  PostCheckNotificationsResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/7/24.
//

import Foundation

struct PostCheckNotificationsResponseDTO: Decodable {
    let notificationId: Int
    
    func toDomain() -> CheckNotificationsResponseEntity {
        return CheckNotificationsResponseEntity(notificationId: notificationId)
    }
}
