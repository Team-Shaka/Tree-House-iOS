//
//  ModifyMyProfileUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol PatchModifyMyProfileUseCaseProtocol {
    func execute(treehouseId: Int, requsetBody: PatchModifyMyProfileRequestDTO) async -> Result<PatchModifyMyProfileResponseEntity, NetworkError>
}

final class ModifyMyProfileUseCase: PatchModifyMyProfileUseCaseProtocol {
    private let repository: MemberRepositoryProtocol
    
    init(repository: MemberRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, requsetBody: PatchModifyMyProfileRequestDTO) async -> Result<PatchModifyMyProfileResponseEntity, NetworkError> {
        return await repository.patchModifyMyProfile(treehouseId: treehouseId, requsetBody: requsetBody)
    }
}
