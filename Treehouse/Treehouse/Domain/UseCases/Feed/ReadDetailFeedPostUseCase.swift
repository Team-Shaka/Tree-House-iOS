//
//  ReadDetailFeedPostUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/26/24.
//

import Foundation

protocol GetReadDetailFeedPostUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int) async -> Result<GetReadDetailFeedPostResponseEntity, NetworkError>
}

final class ReadDetailFeedPostUseCase: GetReadDetailFeedPostUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int) async -> Result<GetReadDetailFeedPostResponseEntity, NetworkError> {
        return await repository.getReadDetailPost(treehouseId: treehouseId, postId: postId)
    }
}
