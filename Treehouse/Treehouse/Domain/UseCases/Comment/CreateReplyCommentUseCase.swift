//
//  CreateReplyCommentUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/28/24.
//

import Foundation

protocol PostCreateReplyCommentUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int, commentId: Int, context: String) async -> Result<CreateCommentResponseEntity, NetworkError>
}

final class CreateReplyCommentUseCase: PostCreateReplyCommentUseCaseProtocol {
    private let repository: CommentRepositoryPorotocol
    
    init(repository: CommentRepositoryPorotocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int, commentId: Int, context: String) async -> Result<CreateCommentResponseEntity, NetworkError> {
        return await repository.postCreateReplyComment(treehouseId: treehouseId, postId: postId, commentId: commentId, context: context)
    }
}
