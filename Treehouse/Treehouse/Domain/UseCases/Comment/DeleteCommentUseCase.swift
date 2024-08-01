//
//  DeleteCommentUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/28/24.
//

import Foundation

protocol DeleteCommentUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int, commentId: Int) async -> Result<Void, NetworkError>
}

final class DeleteCommentUseCase: DeleteCommentUseCaseProtocol {
    private let repository: CommentRepositoryPorotocol
    
    init(repository: CommentRepositoryPorotocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int, commentId: Int) async -> Result<Void, NetworkError> {
        return await repository.deleteComment(treehouseId: treehouseId, postId: postId, commentId: commentId)
    }
}
