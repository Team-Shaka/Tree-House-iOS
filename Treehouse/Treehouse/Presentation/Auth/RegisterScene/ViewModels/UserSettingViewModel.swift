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
    
    // MARK: - UserSetting Property
    
    var userId: String = ""
    var memberName: String?
    var bio: String?
    var profileImageURL: String?
    var phoneNumber: String?
    var treehouseId: Int?

    var errorMessage: String? = nil
    
    // MARK: - State Property
    
    var isPresentedView = false
    var isDuplicateID: Bool = false
    var isButtonEnabled: Bool = false
    var isUserNameDuplicated: Bool = false
    var isAuthentication: UserAuthentication = .error
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkUserNameUseCase: PostCheckNameUseCaseProtocol
    
    @ObservationIgnored
    private let registerUserUseCase: PostRegisterUserUseCaseProtocol
    
    @ObservationIgnored
    private let registerTreeMemberUseCase: PostRegisterTreeMemberUseCaseProtocol
    
    @ObservationIgnored
    private let acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol
    
    // MARK: - init
    
    init(checkNameUseCase: PostCheckNameUseCaseProtocol,
         registerUserUseCase: PostRegisterUserUseCaseProtocol,
         registerTreeMemberUseCase: PostRegisterTreeMemberUseCaseProtocol,
         acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol
    ) {
        self.checkUserNameUseCase = checkNameUseCase
        self.registerUserUseCase = registerUserUseCase
        self.registerTreeMemberUseCase = registerTreeMemberUseCase
        self.acceptInvitationTreeMemberUseCase = acceptInvitationTreeMemberUseCase
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
    
    func registerTreeMember() async {
        guard let treehouseId = treehouseId,
              let memberName = memberName,
              let bio = bio,
              let profileImageURL = profileImageURL else {
            return
        }
        
        let result = await registerTreeMemberUseCase.execute(requestDTO: PostRegisterTreeMemberRequestDTO(treehouseId: treehouseId, userName: userId, memberName: memberName, bio: bio, profileImageURL: profileImageURL))
        
        switch result {
        case .success(let response):
            // TODO: - userId, treehouseId 저장 ( KeyChain, UserDefaults? )
            break
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    func acceptInvitationTreeMember(invitationId: Int, isAccepted: Bool) async {
        let result = await acceptInvitationTreeMemberUseCase.execute(invitationId: invitationId, isAccepted: isAccepted)
        
        switch result {
        case .success(let response):
            // TODO: - invitationid 연결
            break
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}
