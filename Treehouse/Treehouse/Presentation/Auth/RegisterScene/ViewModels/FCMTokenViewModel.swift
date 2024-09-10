//
//  FCMTokenViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation
import Observation

@Observable
final class FCMTokenViewModel: BaseViewModel {
    
    // MARK: - Property
    
    var isSaveFCMToken = false
    var errorMessage: String?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let registerFCMTokenUseCase: PostRegisterFCMTokenUseCaseProtocol
    
    // MARK: - init
    
    init(registerFCMTokenUseCase: PostRegisterFCMTokenUseCaseProtocol) {
        self.registerFCMTokenUseCase = registerFCMTokenUseCase
        
        print("FCMTokenViewModel Init")
    }
    
    deinit {
        print("Deinit FCMTokenViewModel")
    }
}

extension FCMTokenViewModel {
    func registerFCMToken() async {
        let result = await registerFCMTokenUseCase.execute()
        
        switch result {
        case .success(let response):
            await MainActor.run {
                isSaveFCMToken = response.saveFcmToken
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
