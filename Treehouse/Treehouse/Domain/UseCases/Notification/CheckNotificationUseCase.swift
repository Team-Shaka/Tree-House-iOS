//
//  CheckNotificationUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/7/24.
//

import Foundation

protocol PostCheckNotificationUseCaseProtocol {
    func execute(notificationId: Int) async -> Result<CheckNotificationsResponseEntity, NetworkError>
}

final class CheckNotificationUseCase: PostCheckNotificationUseCaseProtocol {
    private let repository: NotificationRepositoryProtocol
    
    init(repository: NotificationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(notificationId: Int) async -> Result<CheckNotificationsResponseEntity, NetworkError> {
        return await repository.postCheckNotification(notificationId: notificationId)
    }
}
