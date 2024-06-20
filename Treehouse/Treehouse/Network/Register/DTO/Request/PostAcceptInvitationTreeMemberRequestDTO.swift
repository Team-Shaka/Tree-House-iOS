//
//  PostAcceptInvitationTreeMemberRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostAcceptInvitationTreeMemberRequestDTO: Codable {
    let invitationId: Int
    let acceptDecision: Bool
}
