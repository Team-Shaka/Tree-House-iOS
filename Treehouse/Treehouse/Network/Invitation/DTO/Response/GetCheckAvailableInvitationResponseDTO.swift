//
//  GetCheckAvailableInvitationResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct GetCheckAvailableInvitationResponseDTO: Decodable {
    let availableInvitation: Int
    let activeRate: Int
    
    func toDomain() -> CheckAvailableInvitationReponseEntity {
        return CheckAvailableInvitationReponseEntity(availableInvitation: availableInvitation, activeRate: activeRate)
    }
}
