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
    func getReadNotifications() async throws -> GetReadNotificationsResponseDTO {
        let request = NetworkRequest(requestType: NotificationAPI.getReadNotifications)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadNotificationsResponseDTO.self)
    }
    
    /// 알림을 읽음 상태로 변경하는 API
    func postCheckNotifications(notificationId: Int) async throws -> PostCheckNotificationsResponseDTO {
        let request = NetworkRequest(requestType: NotificationAPI.postCheckNotifications(notificationId: notificationId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCheckNotificationsResponseDTO.self)
    }
}
