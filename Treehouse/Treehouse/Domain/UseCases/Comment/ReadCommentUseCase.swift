//
//  ReadCommentUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

protocol GetReadCommentUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int) async -> Result<ReadCommentResponseEntity, NetworkError>
}

final class ReadCommentUseCase: GetReadCommentUseCaseProtocol {
    private let repository: CommentRepositoryPorotocol
    
    init(repository: CommentRepositoryPorotocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int) async -> Result<ReadCommentResponseEntity, NetworkError> {
        return await repository.getReadComment(treehouseId: treehouseId, postId: postId)
    }
}
