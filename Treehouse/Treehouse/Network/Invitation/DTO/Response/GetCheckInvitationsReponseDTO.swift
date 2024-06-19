//
//  GetCheckInvitationsReponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct GetCheckInvitationsReponseDTO: Decodable {
    let invitations: [CheckInvitationsReponseData]
    
    func toDomain() -> CheckInvitationsReponseEntity {
        return CheckInvitationsReponseEntity(invitations: invitations)
    }
}
