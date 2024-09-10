//
//  RegisterFCMTokenUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation
import FirebaseMessaging

protocol PostRegisterFCMTokenUseCaseProtocol {
    func execute() async -> Result<RegisterFCMTokenResponseEntity, NetworkError>
}

final class RegisterFCMTokenUseCase: PostRegisterFCMTokenUseCaseProtocol {
    private let repository: RegisterRepositoryProtocol
    
    init(repository: RegisterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<RegisterFCMTokenResponseEntity, NetworkError> {
        let fcmToken = await getFCMToken()
        
        return await repository.postRegisterFCMToken(token: fcmToken)
    }
    
    func getFCMToken() async -> String {
        do {
            let token = try await Messaging.messaging().token()
            print("FCM registration token: \(token)")
            // 여기서 토큰을 사용하거나 저장할 수 있습니다.
            return token
        } catch {
            print("Error fetching FCM registration token: \(error)")
            return ""
        }
    }
}
