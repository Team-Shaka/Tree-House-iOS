//
//  NotificationsRepositoryImpl.swift
//  Treehouse
//
//  Created by 윤영서 on 7/10/24.
//

import Foundation

final class NotificationsRepositoryImpl: NotificationRepositoryProtocol {
    private var notificationService = NotificationService()
    
    /// 알림 조회 Repository Impl
    func getCheckNotification() async -> Result<CheckNotificationResponseEntity, NetworkError> {
        do {
            let response = try await notificationService.getNotifications()
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
