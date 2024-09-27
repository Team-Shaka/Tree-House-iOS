//
//  DeleteFeedPostUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/26/24.
//

import Foundation

protocol DeleteFeedPostUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int) async -> Result<Void, NetworkError>
}

final class DeleteFeedPostUseCase: DeleteFeedPostUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int) async -> Result<Void, NetworkError> {
        return await repository.deleteFeedPost(treehouseId: treehouseId, postId: postId)
    }
}

