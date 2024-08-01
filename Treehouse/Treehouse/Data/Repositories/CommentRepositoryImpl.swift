//
//  CommentRepositoryImpl.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/22/24.
//

import Foundation

final class CommentRepositoryImpl: CommentRepositoryPorotocol {
    private var commentService = CommentService()
    
    /// DetailView 에서 댓글을 불러오는 API
    func getReadComment(treehouseId: Int, postId: Int) async -> Result<ReadCommentResponseEntity, NetworkError> {
        do {
            let response = try await commentService.getReadComment(treehouseId: treehouseId, postId: postId)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// 댓글을 적는 API
    func postCreateComment(treehouseId: Int, postId: Int, context: String) async -> Result<CreateCommentResponseEntity, NetworkError> {
        do {
            let response = try await commentService.postCreateComment(treehouseId: treehouseId, postId: postId, context: context)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// 대댓글을 적는 API
    func postCreateReplyComment(treehouseId: Int, postId: Int, commentId: Int, context: String) async -> Result<CreateCommentResponseEntity, NetworkError> {
        do {
            let response = try await commentService.postCreateReplyComment(treehouseId: treehouseId, postId: postId, commentId: commentId, context: context)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// 댓글을 삭제하는 API
    func deleteComment(treehouseId: Int, postId: Int, commentId: Int) async -> Result<Void,  NetworkError> {
        do {
            let _ = try await commentService.deleteComment(treehouseId: treehouseId, postId: postId, commentId: commentId)
            return .success(())
        } catch let error as NetworkError {
            print(error.localizedDescription)
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// DetailView 에서 댓글의 반응을 적는 API
    func postCreateReactionToComment(treehouseId: Int, postId: Int, commentId: Int, reactionName: String) async -> Result<String, NetworkError> {
        do {
            let response = try await commentService.postCreateReactionToComment(treehouseId: treehouseId, postId: postId, commentId: commentId, reactionName: reactionName)
            return .success(response)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// DetailView 에서 댓글을 신고하는 API
    func postReportComment(treehouseId: Int, postId: Int, commentId: Int, memberId: Int) async -> Result<Void, NetworkError> {
        do {
            let _ = try await commentService.postReportComment(treehouseId: treehouseId, postId: postId, commentId: commentId, memberId: memberId)
            return .success(())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
