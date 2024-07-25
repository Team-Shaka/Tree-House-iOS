//
//  CreateTreehouseUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol PostCreateTreehouseUseCaseProtocol {
    func execute(request: PostCreateTreehouseRequestDTO) async -> Result<CreateTreehouseResponseEntity, NetworkError>
}

final class CreateTreehouseUseCase: PostCreateTreehouseUseCaseProtocol {
    private let repository: TreehouseRepositoryProtocol
    
    init(repository: TreehouseRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(request: PostCreateTreehouseRequestDTO) async -> Result<CreateTreehouseResponseEntity, NetworkError> {
        return await repository.postCreateTreehouse(request: request)
    }
}
