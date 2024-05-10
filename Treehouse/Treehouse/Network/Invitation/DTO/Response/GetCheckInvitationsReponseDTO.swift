//
//  GetCheckInvitationsReponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct GetCheckInvitationsReponseDTO: Decodable {
    let invitations: [GetCheckInvitationsReponseData]
}

struct GetCheckInvitationsReponseData: Decodable {
    let invitationId: Int
    let treehouseName: String
    let senderName: String
    let senderProfileImageUrl: String
    let treehouseSize: Int
    let treehouseMemberProfileImages: [URL]
}
