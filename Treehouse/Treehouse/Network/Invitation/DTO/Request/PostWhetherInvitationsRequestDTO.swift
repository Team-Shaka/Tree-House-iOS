//
//  PostWhetherInvitationsRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostWhetherInvitationsRequestDTO: Codable {
    let invitationId: Int
    let isAccepted: Bool
}
