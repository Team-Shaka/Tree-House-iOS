//
//  NotificationService.swift
//  Treehouse
//
//  Created by 윤영서 on 5/13/24.
//

import Foundation

class NotificationService: NetworkServiceable {

    /// 알림 조회 요청
    func getNotifications(page: Int) async throws -> GetCheckNotificationsResponseDTO {
        var request = URLRequest(url: NotificationAPI.getCheckNotifications.baseURL.appendingPathComponent(NotificationAPI.getCheckNotifications.path + "\(page)"))
        request.httpMethod = NotificationAPI.getCheckNotifications.httpMethod.rawValue
        request.allHTTPHeaderFields = NotificationAPI.getCheckNotifications.headers
        
        return try await performRequest(with: request, decodingType: GetCheckNotificationsResponseDTO.self)
    }
}
