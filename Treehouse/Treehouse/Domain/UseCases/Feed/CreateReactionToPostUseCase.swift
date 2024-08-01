//
//  CreateReactionToPostUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/28/24.
//

import Foundation

protocol PostCreateReactionToPostUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int, requestDTO: PostReactionFeedPostRequestDTO) async -> Result<String, NetworkError>
}

final class CreateReactionToPostUseCase: PostCreateReactionToPostUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int, requestDTO: PostReactionFeedPostRequestDTO) async -> Result<String, NetworkError> {
        return await repository.postCreateReactionToPost(treehouseId: treehouseId, postId: postId, requestDTO: requestDTO)
    }
}
