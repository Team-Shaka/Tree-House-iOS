//
//  CreateFeedPostsUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/31/24.
//

import Foundation

protocol PostCreateFeedPostsUseCaseProtocol {
    func execute(treehouseId: Int, requestBody: PostCreateFeedPostsRequestDTO) async -> Result<CreateFeedPostsResponseResponseEntity, NetworkError>
}

final class CreateFeedPostsUseCase: PostCreateFeedPostsUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, requestBody: PostCreateFeedPostsRequestDTO) async -> Result<CreateFeedPostsResponseResponseEntity, NetworkError> {
        return await repository.postCreateFeedPosts(treehouseId: treehouseId, requestBody: requestBody)
    }
}
