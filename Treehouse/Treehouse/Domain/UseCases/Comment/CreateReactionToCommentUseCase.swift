//
//  CreateReactionToCommentUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/23/24.
//

import Foundation

protocol PostCreateReactionToCommentUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int, commentId: Int, reactionName: String) async -> Result<String, NetworkError>
}

final class CreateReactionToCommentUseCase: PostCreateReactionToCommentUseCaseProtocol {
    private let repository: CommentRepositoryPorotocol
    
    init(repository: CommentRepositoryPorotocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int, commentId: Int, reactionName: String) async -> Result<String, NetworkError> {
        return await repository.postCreateReactionToComment(
            treehouseId: treehouseId,
            postId: postId,
            commentId: commentId,
            reactionName: reactionName
        )
    }
}
