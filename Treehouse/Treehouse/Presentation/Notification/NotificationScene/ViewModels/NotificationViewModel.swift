//
//  NotificationViewModel.swift
//  Treehouse
//
//  Created by 윤영서 on 7/10/24.
//

import Foundation
import Observation

@Observable
final class NotificationViewModel: BaseViewModel {
    
    // MARK: - Notification Property
    
    var type: NotificationTypeEnum = .invitation
    var profileImageUrl: String? = nil
    var userName: String = ""
    var receivedTime: String = ""
    var treehouseName: String = ""
    var isChecked: Bool = false
    var targetId: Int = 0
    
    var notificationData = [NotificationResponseEntity]()
    var errorMessage: String? = nil
    var isLoading = true
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let readNotificationUseCase: GetReadNotificationUseCaseProtocol
    
    @ObservationIgnored
    private let checkNotificationUseCase: PostCheckNotificationUseCaseProtocol
    
    init(
        readNotificationUseCase: GetReadNotificationUseCaseProtocol,
        checkNotificationUseCase: PostCheckNotificationUseCaseProtocol
    ) {
        self.readNotificationUseCase = readNotificationUseCase
        self.checkNotificationUseCase = checkNotificationUseCase
    }
    
    func notificationTapped(notificationId: Int) {
        if let notificationIndex = notificationData.firstIndex(where: { $0.targetId == notificationId}) {
            if notificationData[notificationIndex].isChecked == false {
                notificationData[notificationIndex].isChecked = true
            }
        }
    }
}

// MARK: - Notification API Extension

extension NotificationViewModel {
    func readNotifications() async {
        let result = await readNotificationUseCase.execute()
        
        switch result {
        case .success(let response):
            
            await MainActor.run {
                notificationData = response.notifications.reversed()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isLoading = false
                }
            }
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func checkNotifications(notificationId: Int) async {
        let result = await checkNotificationUseCase.execute(notificationId: notificationId)
        switch result {
        case .success(let response):
            if let index = notificationData.firstIndex(where: { $0.notificationId == response.notificationId }) {
                await MainActor.run {
                    notificationData[index].isChecked = true
                }
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

