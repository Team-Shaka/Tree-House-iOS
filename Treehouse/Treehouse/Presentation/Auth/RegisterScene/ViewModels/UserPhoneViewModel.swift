//
//  UserPhoneViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation
import Observation

@Observable
final class CheckUserPhoneViewModel: BaseViewModel {
    
    // MARK: - Property
    
    var isAuthentication: UserAuthentication = .error
    var errorMessage: String?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkUserPhoneUseCase: PostCheckUserPhoneUseCaseProtocol
    
    // MARK: - init
    
    init(checkUserPhoneUseCase: PostCheckUserPhoneUseCaseProtocol) {
        self.checkUserPhoneUseCase = checkUserPhoneUseCase
        
        print("Init CheckUserPhoneViewModel")
    }
    
    deinit {
        print("Deinit CheckUserPhoneViewModel")
    }
}

extension CheckUserPhoneViewModel {
    func checkUserPhone(phoneNumber: String) async {
        
        let result = await checkUserPhoneUseCase.execute(phoneNumber: phoneNumber.formatPhoneNumber)
        
        switch result {
        case .success(let response):
            switch (response.isInvited, response.isNewUser) {
            case (true, true):
                isAuthentication = .notSignUp
            case (true, false):
                isAuthentication = .comebackUser
            case (false, _):
                isAuthentication = .notInvitation
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
