//
//  NotificationService.swift
//  Treehouse
//
//  Created by 윤영서 on 5/13/24.
//

import Foundation

final class NotificationService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// 알림 조회 요청 서비스
    func getNotifications() async throws -> GetCheckNotificationsResponseDTO {
        let request = NetworkRequest(requestType: NotificationAPI.getCheckNotifications)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetCheckNotificationsResponseDTO.self)
    }
}
