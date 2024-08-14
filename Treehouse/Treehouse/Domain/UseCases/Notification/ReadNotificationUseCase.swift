//
//  CheckNotificationUseCase.swift
//  Treehouse
//
//  Created by 윤영서 on 7/10/24.
//

import Foundation

protocol GetReadNotificationUseCaseProtocol {
    func execute() async -> Result<ReadNotificationResponseEntity, NetworkError>
}

final class ReadNotificationUseCase: GetReadNotificationUseCaseProtocol {
    private let repository: NotificationRepositoryProtocol
    
    init(repository: NotificationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<ReadNotificationResponseEntity, NetworkError> {
        return await repository.getReadNotification()
    }
}
