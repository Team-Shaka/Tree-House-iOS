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
    
    var errorMessage: String? = nil
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkNotificationUseCase: GetCheckNotificationUseCaseProtocol
    
    // MARK: - init
    
//    init(
//        type: NotificationTypeEnum, profileImageUrl: String? = nil, 
//        userName: String,
//        receivedTime: String,
//        treehouseName: String, 
//        isChecked: Bool,
//        targetId: Int,
//        errorMessage: String? = nil,
//        checkNotificationUseCase: GetCheckNotificationUseCaseProtocol
//    ) {
//        self.type = type
//        self.profileImageUrl = profileImageUrl
//        self.userName = userName
//        self.receivedTime = receivedTime
//        self.treehouseName = treehouseName
//        self.isChecked = isChecked
//        self.targetId = targetId
//        self.errorMessage = errorMessage
//        self.checkNotificationUseCase = checkNotificationUseCase
//    }
    
    init(
        checkNotificationUseCase: GetCheckNotificationUseCaseProtocol
    ) {
        self.checkNotificationUseCase = checkNotificationUseCase
    }
}

// MARK: - Notification API Extension

extension NotificationViewModel {
    func checkNotifications() async {
        let result = await checkNotificationUseCase.execute()
        
        switch result {
        case .success(let response):
            response.notifications.forEach {
                profileImageUrl = $0.profileImageUrl
                userName = $0.userName
                receivedTime = $0.receivedTime
                treehouseName = $0.treehouseName
                isChecked = $0.isChecked
                targetId = $0.targetId
            }
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
