//
//  DeleteUserUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/25/24.
//

import Foundation

protocol DeleteUserUseCaseProtocol {
    func execute() async -> Result<DeleteUserResponseEntity, NetworkError>
}

final class DeleteUserUseCase: DeleteUserUseCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<DeleteUserResponseEntity, NetworkError> {
        return await repository.deleteUser()
    }
}
