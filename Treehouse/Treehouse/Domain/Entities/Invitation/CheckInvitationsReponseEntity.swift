//
//  CheckInvitationsReponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

struct CheckInvitationsReponseEntity: Decodable {
    let invitations: [CheckInvitationsDataReponseEntity]
}

struct CheckInvitationsDataReponseEntity: Decodable, Identifiable {
    var id = UUID()
    let invitationId: Int
    let treehouseId: Int
    let treehouseName: String
    let senderName: String
    let senderProfileImageUrl: String?
    let treehouseSize: Int
    let treehouseMemberProfileImages: [String?]
}
