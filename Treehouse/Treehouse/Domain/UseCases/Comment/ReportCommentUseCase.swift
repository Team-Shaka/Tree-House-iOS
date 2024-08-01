//
//  ReportCommentUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/29/24.
//

import Foundation

protocol PostReportCommentUseCaseProtocol {
    func execute(treehouseId: Int, postId: Int, commentId: Int, memberId: Int) async -> Result<Void, NetworkError>
}

final class ReportCommentUseCase: PostReportCommentUseCaseProtocol {
    private let repository: CommentRepositoryPorotocol
    
    init(repository: CommentRepositoryPorotocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, postId: Int, commentId: Int, memberId: Int) async -> Result<Void, NetworkError> {
        return await repository.postReportComment(treehouseId: treehouseId, postId: postId, commentId: commentId, memberId: memberId)
    }
}
