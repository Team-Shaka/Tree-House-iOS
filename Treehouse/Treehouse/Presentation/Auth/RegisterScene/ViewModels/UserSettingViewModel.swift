//
//  UserSettingViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/12/24.
//

import Observation

enum UserAuthentication {
    case notInvitation
    case notSignUp
    case comebackUser
    case error
}

protocol BaseViewModel: AnyObject {}

@Observable
final class UserSettingViewModel: BaseViewModel {
    
    var userId: String = ""
    var isPresentedView = false
    var isDuplicateID: Bool = false
    var isButtonEnabled: Bool = false
    var phoneNumber: String?
    
    var isUserNameDuplicated: Bool = false
    var errorMessage: String? = nil
    
    var isAuthentication: UserAuthentication = .error
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkUserNameUseCase: PostCheckNameUseCaseProtocol
    
    @ObservationIgnored
    private let registerUserUseCase: PostRegisterUserUseCaseProtocol
    
    // MARK: - init
    
    init(checkNameUseCase: PostCheckNameUseCaseProtocol, registerUserUseCase: PostRegisterUserUseCaseProtocol) {
        self.checkUserNameUseCase = checkNameUseCase
        self.registerUserUseCase = registerUserUseCase
    }
}

// MARK: - API Extension

extension UserSettingViewModel {
    func checkUserName(userName: String) async {
        do {
            let response = try await checkUserNameUseCase.excute(userName: userName)
            
            await MainActor.run {
                self.isUserNameDuplicated = response.isDuplicated
            }
        } catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func registerUser() async -> Bool {
        guard let phoneNumber = self.phoneNumber else {
            return false
        }
        print(phoneNumber, userId)
        let result = await registerUserUseCase.execute(phoneNumber: phoneNumber, userName: self.userId)
        
        switch result {
        case .success(let response):
            KeychainHelper.shared.save(response.accessToken, for: Config.accessTokenKey)
            KeychainHelper.shared.save(response.refreshToken, for: Config.refreshTokenKey)
            
            return true
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            return false
        }
    }
}
