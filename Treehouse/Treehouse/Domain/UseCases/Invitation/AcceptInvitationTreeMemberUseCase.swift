//
//  AcceptInvitationTreeMemberUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

protocol PostAcceptInvitationTreeMemberUseCaseProtocol {
    func execute(invitationId: Int, isAccepted: Bool) async -> Result<AcceptInvitationTreeMemberResponseEntity, NetworkError>
}

final class AcceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol {
    private let repository: InvitationReposiotryProtocol
    
    init(repository: InvitationReposiotryProtocol) {
        self.repository = repository
    }

    func execute(invitationId: Int, isAccepted: Bool) async -> Result<AcceptInvitationTreeMemberResponseEntity, NetworkError> {
        return await repository.postAcceptInvitationTreeMember(invitationId: invitationId, isAccepted: isAccepted)
    }
}
