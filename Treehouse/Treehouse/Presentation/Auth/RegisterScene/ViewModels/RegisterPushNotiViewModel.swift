//
//  RegisterPushNotiViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation
import Observation
import UserNotifications

@Observable
final class RegisterPushNotiViewModel: BaseViewModel {
    
    // MARK: - Property
    
    var isPostPushAgree = false
    var notificationStatus = false
    var errorMessage: String?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let registerPushAgreeUseCase: PostRegisterPushAgreeUseCaseProtocol
    
    // MARK: - init
    
    init(registerPushAgreeUseCase: PostRegisterPushAgreeUseCaseProtocol) {
        self.registerPushAgreeUseCase = registerPushAgreeUseCase
        
        checkNotificationStatus()
        print("RegisterPushNotiViewModel Init")
    }
    
    deinit {
        print("Deinit RegisterPushNotiViewModel")
    }
    
    func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized:
                    print("알림 허용됨")
                    self.notificationStatus = true
                case .denied:
                    print("알림 거부됨")
                    self.notificationStatus = false
                case .notDetermined:
                    print("알림 상태 미결정")
                    self.notificationStatus = false
                case .provisional:
                    print("임시 알림 허용")
                    self.notificationStatus = false
                case .ephemeral:
                    print("임시 세션 알림")
                    self.notificationStatus = false
                @unknown default:
                    print("알 수 없는 상태")
                    self.notificationStatus = false
                }
            }
        }
    }
}

extension RegisterPushNotiViewModel {
    func registerPushAgree() async {
        let result = await registerPushAgreeUseCase.execute(pushAgree: notificationStatus)
        
        switch result {
        case .success(_):
            await MainActor.run {
                isPostPushAgree = true
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
