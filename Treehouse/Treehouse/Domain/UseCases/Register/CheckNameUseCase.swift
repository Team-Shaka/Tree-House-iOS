//
//  CheckNameUseCase.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/1/24.
//

import Foundation

protocol PostCheckNameUseCaseProtocol {
    func excute(userName: String) async throws -> CheckNameResponseEntity
}

final class CheckNameUseCase: PostCheckNameUseCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func excute(userName: String) async throws -> CheckNameResponseEntity {
        return try await repository.postCheckName(userName: userName)
    }
}
