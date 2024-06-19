//
//  FeedService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

final class FeedService {
    
    /// S3 에 이미지를 올리기 위한 PresignedURL 을 받는 API
    func postPresignedURL(treehouseId: Int, fileName: String, fileSize: Int) async throws -> PostPresignedURLResponseDTO {
        
        print("1️⃣ PostPresignedURL API 호출 ========================================")
        print("Input - treehouseId: \(treehouseId), fileName: \(fileName), flieSize: \(fileSize)")
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: FeedAPI.postPresignedURL(treehouseId: treehouseId, requestBody: PostPresignedURLRequestDTO(fileName: fileName, fileSize: fileSize)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        print("호출한 url: \(String(describing: urlRequest.url))")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostPresignedURLResponseDTO>.self, from: data)
            print(model.data)
            print("4️⃣ PostPresignedURL API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ PostPresignedURL API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
}
