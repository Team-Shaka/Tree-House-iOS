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
}
