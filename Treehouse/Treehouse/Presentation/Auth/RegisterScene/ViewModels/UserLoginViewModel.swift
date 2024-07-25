//
//  UserLoginViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation
import Observation

@Observable
final class UserLoginViewModel: BaseViewModel {
    
    // MARK: - Property
    
    var isLogin: Bool = false
    var errorMessage: String?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let existsUserLoginUseCase: PostExistsUserLoginUserCaseProtocol
    
    // MARK: - init
    
    init(existsUserLoginUseCase: PostExistsUserLoginUserCaseProtocol) {
        self.existsUserLoginUseCase = existsUserLoginUseCase
    }
    
    deinit {
        print("Deinit UserLoginViewModel")
    }
}

extension UserLoginViewModel {
    func existsUserLogin(phoneNumber: String) async {
        print(phoneNumber)
        let result = await existsUserLoginUseCase.execute(phoneNumber: phoneNumber)
        
        switch result {
        case .success(let response):
            KeychainHelper.shared.save(response.accessToken, for: Config.accessTokenKey)
            KeychainHelper.shared.save(response.refreshToken, for: Config.refreshTokenKey)
            
            isLogin = true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            isLogin = false
        }
    }
}
