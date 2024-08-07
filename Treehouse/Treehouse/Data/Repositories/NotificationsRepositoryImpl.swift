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
    func getReadNotification() async -> Result<ReadNotificationResponseEntity, NetworkError> {
        do {
            let response = try await notificationService.getReadNotifications()
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// 알림을 읽음 상태로 변경하는 Repository Impl
    func postCheckNotification(notificationId: Int) async -> Result<CheckNotificationsResponseEntity, NetworkError> {
        do {
            let response = try await notificationService.postCheckNotifications(notificationId: notificationId)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
