//
//  ReadMemberInfoUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol GetReadMemberInfoUseCaseProtocol {
    func execute(treehouseId: Int, memberId: Int) async -> Result<ReadMemberInfoResponseEntity, NetworkError>
}

final class ReadMemberInfoUseCase: GetReadMemberInfoUseCaseProtocol {
    private let repository: MemberRepositoryProtocol
    
    init(repository: MemberRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, memberId: Int) async -> Result<ReadMemberInfoResponseEntity, NetworkError> {
        return await repository.getReadMemberInfo(treehouseId: treehouseId, memberId: memberId)
    }
}
