//
//  PostAcceptInvitationTreeMemberResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostAcceptInvitationTreeMemberResponseDTO: Decodable {
    let treehouseId: Int
    let isAccepted: Bool
    
    func toDomain() -> AcceptInvitationTreeMemberResponseEntity {
        return AcceptInvitationTreeMemberResponseEntity(treehouseId: treehouseId, isAccepted: isAccepted)
    }
}
