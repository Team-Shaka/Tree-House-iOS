//
//  ReadMemberFeedUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol GetReadMemberFeedUseCaseProtocol {
    func execute(treehouseId: Int, memberId: Int) async -> Result<ReadMemberFeedResponseEntity, NetworkError>
}

final class ReadMemberFeedUseCase: GetReadMemberFeedUseCaseProtocol {
    private let repository: MemberRepositoryProtocol
    
    init(repository: MemberRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, memberId: Int) async -> Result<ReadMemberFeedResponseEntity, NetworkError> {
        return await repository.getReadMemberFeed(treehouseId: treehouseId, memberId: memberId)
    }
}
