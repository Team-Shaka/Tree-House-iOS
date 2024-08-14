//
//  ReadPageFeedPostUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/12/24.
//

import Foundation

protocol GetPageReadFeedPostUseCaseProtocol {
    func execute(treehouseId: Int, page: Int) async -> Result<[GetReadFeedPostListResponseEntity], NetworkError>
}

final class ReadPageFeedPostUseCase: GetPageReadFeedPostUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, page: Int) async -> Result<[GetReadFeedPostListResponseEntity], NetworkError> {
        return await repository.getPageReadFeedPost(treehouseId: treehouseId, page: page)
    }
}
