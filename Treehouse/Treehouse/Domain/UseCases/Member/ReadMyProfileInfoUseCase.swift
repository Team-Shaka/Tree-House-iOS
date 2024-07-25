//
//  ReadMyProfileInfoUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol GetReadMyProfileInfoUseCaseProtocol {
    func execute(treehouseId: Int) async -> Result<ReadMyProfileInfoResponseEntity, NetworkError>
}

final class ReadMyProfileInfoUseCase: GetReadMyProfileInfoUseCaseProtocol {
    private let repository: MemberRepositoryProtocol
    
    init(repository: MemberRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int) async -> Result<ReadMyProfileInfoResponseEntity, NetworkError> {
        return await repository.getReadMyProfileInfo(treehouseId: treehouseId)
    }
}
