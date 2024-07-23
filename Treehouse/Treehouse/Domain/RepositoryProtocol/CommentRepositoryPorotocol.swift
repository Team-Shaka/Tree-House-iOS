//
//  CommentRepositoryPorotocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/22/24.
//

import Foundation

protocol CommentRepositoryPorotocol {
    func postCreateComment(treehouseId: Int, postId: Int, context: String) async -> Result<CreateCommentResponseEntity,NetworkError>
    func getReadComment(treehouseId: Int, postId: Int) async -> Result<ReadCommentResponseEntity, NetworkError>
    func postCreateReactionToComment(treehouseId: Int, postId: Int, commentId: Int, reactionName: String) async -> Result<String, NetworkError>
}
