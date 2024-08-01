//
//  CreateCommentUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

protocol PostCreateCommentUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int, context: String) async -> Result<CreateCommentResponseEntity, NetworkError>
}

final class CreateCommentUseCase: PostCreateCommentUseCaseProtocol {
    private let repository: CommentRepositoryPorotocol
    
    init(repository: CommentRepositoryPorotocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int, context: String) async -> Result<CreateCommentResponseEntity, NetworkError> {
        return await repository.postCreateComment(treehouseId: treehouseId, postId: postId, context: context)
    }
}
