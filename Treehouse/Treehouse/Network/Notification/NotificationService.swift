//
//  NotificationService.swift
//  Treehouse
//
//  Created by 윤영서 on 5/13/24.
//

import Foundation

final class NotificationService {
    
    /// 알림 조회 요청 서비스
    func getNotifications() async throws -> GetCheckNotificationsResponseDTO {
        print("1️⃣ 🔑 GetCheckNotifications API 호출 ========================================")
        let request = NetworkRequest(requestType: NotificationAPI.getCheckNotifications)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
            print("\(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<GetCheckNotificationsResponseDTO>.self, from: data)
            print(model.data.notifications)
            print("4️⃣ GetCheckNotification API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ GetCheckNotifiication API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
}
