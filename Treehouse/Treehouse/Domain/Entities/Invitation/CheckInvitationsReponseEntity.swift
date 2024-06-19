//
//  CheckInvitationsReponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

struct CheckInvitationsReponseEntity: Decodable {
    let invitations: [CheckInvitationsReponseData]
}

struct CheckInvitationsReponseData: Decodable {
    let invitationId: Int
    let treehouseName: String
    let senderName: String
    let senderProfileImageUrl: String
    let treehouseSize: Int
    let treehouseMemberProfileImages: [URL]
}
