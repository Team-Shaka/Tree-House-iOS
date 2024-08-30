//
//  InvitationUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/28/24.
//

import Foundation

protocol PostInvitationUseCaseProtocol {
    func execute(senderId: Int, phoneNumber: String, treehouseId: Int) async -> Result<InvitationResponseEntity, NetworkError>
}

final class InvitationUseCase: PostInvitationUseCaseProtocol {
    private let repository: InvitationRepositoryProtocol
    
    init(repository: InvitationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(senderId: Int, phoneNumber: String, treehouseId: Int) async -> Result<InvitationResponseEntity, NetworkError> {
        return await repository.postInvitation(senderId: senderId, phoneNumber: phoneNumber, treehouseId: treehouseId)
    }
}
