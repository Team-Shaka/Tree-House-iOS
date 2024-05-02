//
//  PostCheckNameUseCase.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/1/24.
//

import Foundation

protocol PostCheckNameUseCase {
    func excute(
        userName: String
    ) async throws -> CheckNameResponseEntity
}

final class DefaultPostCheckNameUseCase: PostCheckNameUseCase {
    
    private let repository: RegisterRepository
    
    init(repository: RegisterRepository) {
        self.repository = repository
    }
    
    func excute(
        userName: String
    ) async throws -> CheckNameResponseEntity {
        try await repository.postCheckName(userName: userName)
    }
}
