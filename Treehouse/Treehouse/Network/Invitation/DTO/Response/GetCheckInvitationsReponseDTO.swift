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
        return CheckInvitationsReponseEntity(invitations: convertCheckInvitationsReponseEntity(invitations))
    }
    
    private func convertCheckInvitationsReponseEntity(_ data: [CheckInvitationsReponseData]) -> [CheckInvitationsDataReponseEntity] {
        var result = [CheckInvitationsDataReponseEntity]()
        
        data.forEach {
            result.append(CheckInvitationsDataReponseEntity(invitationId: $0.invitationId, treehouseId: $0.treehouseId, treehouseName: $0.treehouseName, senderName: $0.senderName, senderProfileImageUrl: $0.senderProfileImageUrl, treehouseSize: $0.treehouseSize, treehouseMemberProfileImages: $0.treehouseMemberProfileImages))
        }
        
        return result
    }
}

struct CheckInvitationsReponseData: Decodable {
    let invitationId: Int
    let treehouseId: Int
    let treehouseName: String
    let senderName: String
    let senderProfileImageUrl: String?
    let treehouseSize: Int
    let treehouseMemberProfileImages: [String?]
}
