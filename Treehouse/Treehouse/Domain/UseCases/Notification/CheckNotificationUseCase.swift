//
//  CheckNotificationUseCase.swift
//  Treehouse
//
//  Created by 윤영서 on 7/10/24.
//

import Foundation

protocol GetCheckNotificationUseCaseProtocol {
    func execute() async ->
    Result<CheckNotificationResponseEntity, NetworkError>
}

final class CheckNotificationUseCase: GetCheckNotificationUseCaseProtocol {
    private let repository: NotificationRepositoryProtocol
    
    init(repository: NotificationRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<CheckNotificationResponseEntity, NetworkError> {
        return await repository.getCheckNotification()
    }
}
