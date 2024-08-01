//
//  UpdateFeedPostUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/31/24.
//

import Foundation

protocol PatchUpdateFeedPostUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int, context: String) async -> Result<UpdateFeedPostResponseEntity, NetworkError>
}

final class UpdateFeedPostUseCase: PatchUpdateFeedPostUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int, context: String) async -> Result<UpdateFeedPostResponseEntity, NetworkError> {
        return await repository.patchUpdateFeedPost(treehouseId: treehouseId, postId: postId, context: context)
    }
}
