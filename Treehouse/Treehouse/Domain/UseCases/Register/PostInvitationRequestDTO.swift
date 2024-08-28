//
//  PostInvitationRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/28/24.
//

import Foundation

struct PostInvitationRequestDTO: Codable {
    let senderId: Int
    let phoneNumber: String
    let treehouseId: Int
}
