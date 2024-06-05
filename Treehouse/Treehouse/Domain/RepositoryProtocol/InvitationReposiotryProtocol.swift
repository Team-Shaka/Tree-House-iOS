//
//  InvitationReposiotryProtocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

protocol InvitationReposiotryProtocol {
    func postAcceptInvitationTreeMember(invitationId: Int, isAccepted: Bool) async -> Result<AcceptInvitationTreeMemberResponseEntity, NetworkError>
    
    func getCheckAvailableInvitation() async -> Result<CheckInvitationsReponseEntity,NetworkError>
}