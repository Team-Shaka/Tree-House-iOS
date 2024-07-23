//
//  FeedService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

final class FeedService {
    
    private let networkServiceManager = NetworkServiceManager()
    
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
