//
//  RegisterUserUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/3/24.
//

import Foundation

protocol PostRegisterUserUseCaseProtocol {
    func execute(phoneNumber: String, userName: String) async -> Result<RegisterUserResponseEntity, NetworkError>
}

final class RegisterUserUseCase: PostRegisterUserUseCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }

    func execute(phoneNumber: String, userName: String) async -> Result<RegisterUserResponseEntity, NetworkError> {
        return await repository.postRegisterUser(phoneNumber: phoneNumber, userName: userName)
    }
}
