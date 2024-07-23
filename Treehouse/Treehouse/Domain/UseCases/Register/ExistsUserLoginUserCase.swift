//
//  ExistsUserLoginUserCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

protocol PostExistsUserLoginUserCaseProtocol {
    func execute(phoneNumber: String) async -> Result<ExistsUserLoginResponseEntity, NetworkError>
}

final class ExistsUserLoginUserCase: PostExistsUserLoginUserCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(phoneNumber: String) async -> Result<ExistsUserLoginResponseEntity, NetworkError> {
        return await repository.postExistsUserLogin(phoneNumber: phoneNumber)
    }
}
