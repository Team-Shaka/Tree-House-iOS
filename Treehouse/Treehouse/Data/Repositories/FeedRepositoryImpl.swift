//
//  FeedRepositoryImpl.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

final class FeedRepositoryImpl: FeedRepositoryProtocol {
    private var feedService = FeedService()
    
    /// S3 에 이미지를 올리기 위한 PresignedURL 을 받는 API
    func postPresignedURL(treehouseId: Int, fileName: String, fileSize: Int) async -> Result<PresignedURLResponseEntity, NetworkError> {
        do {
            let response = try await feedService.postPresignedURL(treehouseId: treehouseId, fileName: fileName, fileSize: fileSize)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// Feed 의 게시글을 불러오기 위한 API
    func getReadPost(treehouseId: Int) async -> Result<[GetReadFeedPostListResponseEntity], NetworkError>{
        do {
            let response = try await feedService.getReadPost(treehouseId: treehouseId)
            return .success(response.map { $0.toDomain() })
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// Feed 에 게시글을 작성하기 위한 API
    func postCreateFeedPosts(treehouseId: Int, requestBody: PostCreateFeedPostsRequestDTO) async -> Result<CreateFeedPostsResponseResponseEntity, NetworkError>{
        do {
            let response = try await feedService.postCreateFeedPosts(treehouseId: treehouseId, requestBody: requestBody)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// Feed 의 게시글을 수정하는 API
    func patchUpdateFeedPost(treehouseId: Int, postId: Int, context: String) async -> Result<UpdateFeedPostResponseEntity, NetworkError> {
        do {
            let response = try await feedService.patchUpdateFeedPost(treehouseId: treehouseId, postId: postId, context: context)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// Feed 의 Detail 게시글을 읽어오는 API
    func getReadDetailPost(treehouseId: Int, postId: Int) async -> Result<GetReadDetailFeedPostResponseEntity, NetworkError> {
        do {
            let response = try await feedService.getReadDetailFeedPosts(treehouseId: treehouseId, postId: postId)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// Feed 의 게시글 반응을 하는 API
    func postCreateReactionToPost(treehouseId: Int, postId: Int, requestDTO: PostReactionFeedPostRequestDTO) async -> Result<String, NetworkError> {
        do {
            let response = try await feedService.postReactionFeedPost(treehouseId: treehouseId, postId: postId, requestBody: requestDTO)
            return .success(response)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
