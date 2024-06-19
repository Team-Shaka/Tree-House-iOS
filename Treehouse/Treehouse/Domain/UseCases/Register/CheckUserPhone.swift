//
//  CheckUserPhone.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/6/24.
//

import Foundation

protocol PostCheckUserPhoneUseCaseProtocol {
    func execute(phoneNumber: String) async -> Result<CheckUserPhoneResponseEntity, NetworkError>
}

final class CheckUserPhoneUseCase: PostCheckUserPhoneUseCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }

    func execute(phoneNumber: String) async -> Result<CheckUserPhoneResponseEntity, NetworkError> {
        return await repository.postCheckUserPhone(phoneNumber: phoneNumber)
    }
}
