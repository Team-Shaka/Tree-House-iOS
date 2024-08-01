//
//  GetCheckNotificationsResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct GetCheckNotificationsResponseDTO: Decodable {
    let notifications: [CheckNotificationResponseData]
    
    func toDomain() -> CheckNotificationResponseEntity {
        return CheckNotificationResponseEntity(notifications: notifications)
    }
}
