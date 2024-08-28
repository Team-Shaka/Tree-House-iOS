//
//  InvitationRepositoryProtocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

protocol InvitationRepositoryProtocol {
    func postAcceptInvitationTreeMember(invitationId: Int, acceptDecision: Bool) async -> Result<AcceptInvitationTreeMemberResponseEntity, NetworkError>
    func postInvitation(senderId: Int, phoneNumber: String, treehouseId: Int) async -> Result<InvitationResponseEntity, NetworkError>
    func getCheckInvitation() async -> Result<CheckInvitationsReponseEntity,NetworkError>
    func getCheckAvailableInvitation() async -> Result<CheckAvailableInvitationReponseEntity,NetworkError>
}
