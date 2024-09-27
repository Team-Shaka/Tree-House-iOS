//
//  FeedService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

final class FeedService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// Feed 의 게시글을 읽어오는 API
    func getReadPost(treehouseId: Int) async throws -> [GetReadFeedPostsListResponseDTO] {
        let request = NetworkRequest(requestType: FeedAPI.getReadFeedPostsList(treehouseId: treehouseId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: [GetReadFeedPostsListResponseDTO].self)
    }
    
    /// Feed 의 게시글을 페이지네이션으로 읽어오는 API
    func getPageReadFeedPost(treehouseId: Int, page: Int) async throws -> [GetReadFeedPostsListResponseDTO] {
        let request = NetworkRequest(requestType: FeedAPI.getPageReadFeedPostsList(treehouseId: treehouseId, page: page))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: [GetReadFeedPostsListResponseDTO].self)
    }
    
    /// Feed 의 게시글을 작성하는 API
    func postCreateFeedPosts(treehouseId: Int, requestBody: PostCreateFeedPostsRequestDTO) async throws -> PostCreateFeedPostsResponseDTO {
        let request = NetworkRequest(requestType: FeedAPI.postCreateFeedPosts(treehouseId: treehouseId, requestBody: requestBody))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCreateFeedPostsResponseDTO.self)
    }
    
    /// Feed 의 Detail 게시글을 읽어오는 API
    func getReadDetailFeedPosts(treehouseId: Int, postId: Int) async throws -> GetReadDetailFeedPostsResponseDTO {
        let request = NetworkRequest(requestType: FeedAPI.getReadDetailFeedPosts(treehouseId: treehouseId, postId: postId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadDetailFeedPostsResponseDTO.self)
    }
    
    /// Feed 의 게시글을 삭제하는 API
    func deleteFeedPost(treehouseId: Int, postId: Int) async throws -> Empty {
        let request = NetworkRequest(requestType: FeedAPI.deleteFeedPost(treehouseId: treehouseId, postId: postId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: Empty.self)
    }
    
    /// Feed 의 게시글을 수정하는 API
    func patchUpdateFeedPost(treehouseId: Int, postId: Int, context: String) async throws -> PatchUpdateFeedPostResponseDTO {
        let request = NetworkRequest(requestType: FeedAPI.patchUpdateFeedPost(treehouseId: treehouseId, postId: postId, requestBody: PatchUpdateFeedPostRequestDTO(context: context)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PatchUpdateFeedPostResponseDTO.self)
    }
    
    /// Feed 의 게시글 반응을 하는 API
    func postReactionFeedPost(treehouseId: Int, postId: Int, requestBody: PostReactionFeedPostRequestDTO) async throws -> String {
        let request = NetworkRequest(requestType: FeedAPI.postReactionFeedPost(treehouseId: treehouseId, postId: postId, requestBody: requestBody))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: String.self)
    }
    
    /// S3 에 이미지를 올리기 위한 PresignedURL 을 받는 API
    func postPresignedURL(treehouseId: Int, fileName: String, fileSize: Int) async throws -> PostPresignedURLResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: FeedAPI.postPresignedURL(treehouseId: treehouseId, requestBody: PostPresignedURLRequestDTO(fileName: fileName, fileSize: fileSize)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostPresignedURLResponseDTO.self)
    }
}
