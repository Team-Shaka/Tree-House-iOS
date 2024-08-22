//
//  MyProfileViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/1/24.
//

import Foundation
import Observation

@Observable
final class MyProfileViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let readMyProfileInfoUseCase:  GetReadMyProfileInfoUseCaseProtocol
    
    var myProfileData: ReadMyProfileInfoResponseEntity?
    var isLoadedMyProfile = false
    var isAlert: (Bool, AlertType) = (false, .logout)
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(readMyProfileInfoUseCase: GetReadMyProfileInfoUseCaseProtocol) {
        self.readMyProfileInfoUseCase = readMyProfileInfoUseCase
    }
    
    func buttonAction(titleName: String) {
        switch titleName {
        case "로그아웃 하기":
            isAlert.0.toggle()
            isAlert.1 = .logout
            
            KeychainHelper.shared.delete(for: Config.accessTokenKey)
            KeychainHelper.shared.delete(for: Config.refreshTokenKey)
            
        case "회원탈퇴 하기":
            isAlert.0.toggle()
            
            KeychainHelper.shared.delete(for: Config.accessTokenKey)
            KeychainHelper.shared.delete(for: Config.refreshTokenKey)
            
        default:
            break
        }
    }
}

extension MyProfileViewModel {
    func readMyProfileInfo(treehouseId: Int) async -> Bool {
        let result = await readMyProfileInfoUseCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            myProfileData = response
            isLoadedMyProfile.toggle()

            return false
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            return true
        }
    }
}
