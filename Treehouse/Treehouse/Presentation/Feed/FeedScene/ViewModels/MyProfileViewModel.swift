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
    
    @ObservationIgnored
    private let deleteUserUseCase: DeleteUserUseCaseProtocol
    
    var myProfileData: ReadMyProfileInfoResponseEntity?
    var isLoadedMyProfile = false
    var isDeleteUser = false
    var isPresentedAlert: Bool = false
    
    var presentedAlertType: AlertType?
    
    var isWebViewPresented = false
    var webViewUrl = ""
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(readMyProfileInfoUseCase: GetReadMyProfileInfoUseCaseProtocol,
         deleteUserUseCase: DeleteUserUseCaseProtocol
    ) {
        self.readMyProfileInfoUseCase = readMyProfileInfoUseCase
        self.deleteUserUseCase = deleteUserUseCase
    }
    
    func settingListButtonAction(titleName: String) {
        switch titleName {
        case "운영정책":
            isWebViewPresented.toggle()
            webViewUrl = "https://sites.google.com/view/treehouse-manage/%ED%99%88"
            
        case "개인정보정책":
            isWebViewPresented.toggle()
            webViewUrl = "https://sites.google.com/view/treehouse-privacy/%ED%99%88"
            
        case "로그아웃 하기":
            isPresentedAlert.toggle()
            presentedAlertType = .logout

        case "회원탈퇴 하기":
            isPresentedAlert.toggle()
            presentedAlertType = .deleteAccount

        default:
            break
        }
    }
    
    func deleteServerToken() {
        KeychainHelper.shared.delete(for: Config.accessTokenKey)
        KeychainHelper.shared.delete(for: Config.refreshTokenKey)
    }
}

extension MyProfileViewModel {
    func readMyProfileInfo(treehouseId: Int) async -> Bool {
        let result = await readMyProfileInfoUseCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            myProfileData = response
            isLoadedMyProfile = true
            
            return false
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            return true
        }
    }
    
    func deleteUser() async {
        let result = await deleteUserUseCase.execute()
        
        switch result {
        case .success(let response):
            isDeleteUser = true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
    }
}
