//
//  CommentService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/17/24.
//

import Foundation

final class CommentService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// DetailView 에서 댓글을 읽는 API
    func getReadComment(treehouseId: Int, postId: Int) async throws -> GetReadCommentResponseDTO {
        
        let request = NetworkRequest(requestType: CommentAPI.getReadCommentsList(treehouseId: treehouseId, postId: postId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadCommentResponseDTO.self)
    }
    
    /// DetailView 에서 댓글을 적는 API
    func postCreateComment(treehouseId: Int, postId: Int, context: String) async throws -> PostCreateCommentResponseDTO {

        let request = NetworkRequest(requestType: CommentAPI.postCreateComment(treehouseId: treehouseId, postId: postId, requestBody: PostCreateCommentRequestDTO(context: context)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCreateCommentResponseDTO.self)
    }
    
    /// DetailView 에서 댓글에 댓글을 적는 API
    func postCreateReplyComment(treehouseId: Int, postId: Int, commentId: Int, context: String) async throws -> PostCreateReplyCommentResponseDTO {
        
        let request = NetworkRequest(requestType: CommentAPI.postCreateReplyComment(treehouseId: treehouseId, postId: postId, commentId: commentId, requestBody: PostCreateCommentRequestDTO(context: context)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCreateReplyCommentResponseDTO.self)
    }
    
    /// DettailView 에서 댓글을 삭제하는 API
    func deleteComment(treehouseId: Int, postId: Int, commentId: Int) async throws -> Empty {
        let request = NetworkRequest(requestType: CommentAPI.deleteComment(treehouseId: treehouseId, postId: postId, commentId: commentId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: Empty.self)
    }
    
    /// DetailView 에서 댓글에 대한 반응을 하는 API
    func postCreateReactionToComment(treehouseId: Int, postId: Int, commentId: Int, reactionName: String) async throws -> String {
        
        let request = NetworkRequest(requestType: CommentAPI.postReactionComment(treehouseId: treehouseId, postId: postId, commentId: commentId, requestBody: PostReactionCommentRequestDTO(reactionName: reactionName)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: String.self)
    }
    
    /// DetailView 에서 댓글을 신고하는 API
    func postReportComment(treehouseId: Int, postId: Int, commentId: Int, memberId: Int) async throws -> Empty {
        let request = NetworkRequest(requestType: CommentAPI.postReportComment(treehouseId: treehouseId, postId: postId, commentId: commentId, requestBody: PostReportFeedCommentRequestDTO(reason: "부적절한 댓글", targetMemberId: memberId)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: Empty.self)
    }
}

struct Empty: Decodable { }
