//
//  CheckAvailableInvitationUseCase.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/20/24.
//

import Foundation

protocol GetCheckAvailableInvitationUseCaseProtocol {
    func execute() async -> Result<CheckAvailableInvitationReponseEntity, NetworkError>
}

final class CheckAvailableInvitationUseCase: GetCheckAvailableInvitationUseCaseProtocol {
    private let repository: InvitationRepositoryProtocol
    
    init(repository: InvitationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<CheckAvailableInvitationReponseEntity, NetworkError> {
        return await repository.getCheckAvailableInvitation()
    }
}
