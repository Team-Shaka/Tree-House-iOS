//
//  RegisterTreeMemberUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/3/24.
//

import Foundation

protocol PostRegisterTreeMemberUseCaseProtocol {
    func execute(registerType: RegisterType, requestDTO: PostRegisterTreeMemberRequestDTO) async -> Result<RegisterTreeMemberResponseEntity, NetworkError>
}

final class RegisterTreeMemberUseCase: PostRegisterTreeMemberUseCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }

    func execute(registerType: RegisterType, requestDTO: PostRegisterTreeMemberRequestDTO) async -> Result<RegisterTreeMemberResponseEntity, NetworkError> {
        return await repository.postRegisterTreeMember(registerType: registerType, requestDTO: requestDTO)
    }
}
