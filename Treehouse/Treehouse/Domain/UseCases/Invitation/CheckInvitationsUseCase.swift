//
//  CheckInvitationsUserCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

protocol GetCheckInvitationsUseCaseProtocol {
    func execute() async -> Result<CheckInvitationsReponseEntity, NetworkError>
}

final class CheckInvitationsUseCase: GetCheckInvitationsUseCaseProtocol {
    private let repository: InvitationReposiotryProtocol
    
    init(repository: InvitationReposiotryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<CheckInvitationsReponseEntity, NetworkError> {
        return await repository.getCheckAvailableInvitation()
    }
}
