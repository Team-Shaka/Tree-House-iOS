//
//  NotificationRepositoryProtocol.swift
//  Treehouse
//
//  Created by 윤영서 on 7/10/24.
//

import Foundation

protocol NotificationRepositoryProtocol {
    func getReadNotification() async -> Result<ReadNotificationResponseEntity, NetworkError>
    func postCheckNotification(notificationId: Int) async -> Result<CheckNotificationsResponseEntity, NetworkError>
}
