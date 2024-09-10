//
//  RegisterPushAgreeUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation

protocol PostRegisterPushAgreeUseCaseProtocol {
    func execute(pushAgree: Bool) async -> Result<RegisterPushAgreeResponseEntity, NetworkError>
}

final class RegisterPushAgreeUseCase: PostRegisterPushAgreeUseCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(pushAgree: Bool) async -> Result<RegisterPushAgreeResponseEntity, NetworkError> {
        return await repository.postRegisterPushAgree(pushAgree: pushAgree)
    }
}
