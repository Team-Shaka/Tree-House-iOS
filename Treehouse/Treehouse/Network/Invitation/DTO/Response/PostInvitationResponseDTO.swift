//
//  PostInvitationResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/28/24.
//

import Foundation

struct PostInvitationResponseDTO: Decodable {
    let invitationId: Int
    
    func toDomain() -> InvitationResponseEntity {
        return InvitationResponseEntity(invitationId: invitationId)
    }
}
