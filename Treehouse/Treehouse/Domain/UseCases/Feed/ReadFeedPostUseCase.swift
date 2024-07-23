//
//  ReadFeedPostUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/22/24.
//

import Foundation

protocol GetReadFeedPostUseCaseProtocol {
    func execute(treehouseId: Int) async -> Result<[GetReadFeedPostListResponseEntity], NetworkError>
}

final class ReadFeedPostUseCase: GetReadFeedPostUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int) async -> Result<[GetReadFeedPostListResponseEntity], NetworkError> {
        return await repository.getReadPost(treehouseId: treehouseId)
    }
}
