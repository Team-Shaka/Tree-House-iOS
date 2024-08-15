//
//  UserLoginViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class UserLoginViewModel: BaseViewModel {
    
    // MARK: - Property
    
    var isLogin: Bool = false
    var isSvaeTreeInfo: Bool = false
    var errorMessage: String?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let existsUserLoginUseCase: PostExistsUserLoginUserCaseProtocol
    
    @ObservationIgnored
    private let readMyProfileInfoUseCase: GetReadMyProfileInfoUseCaseProtocol
    
    // MARK: - init
    
    init(existsUserLoginUseCase: PostExistsUserLoginUserCaseProtocol,
         readMyProfileInfoUseCase: GetReadMyProfileInfoUseCaseProtocol
    ) {
        self.existsUserLoginUseCase = existsUserLoginUseCase
        self.readMyProfileInfoUseCase = readMyProfileInfoUseCase
    }
    
    deinit {
        print("Deinit UserLoginViewModel")
    }
}

extension UserLoginViewModel {
    func existsUserLogin(phoneNumber: String) async -> UserInfoData? {
        print(phoneNumber)
        let result = await existsUserLoginUseCase.execute(phoneNumber: phoneNumber)
        
        switch result {
        case .success(let response):
            KeychainHelper.shared.save(response.accessToken, for: Config.accessTokenKey)
            KeychainHelper.shared.save(response.refreshToken, for: Config.refreshTokenKey)
            
            return UserInfoData(userId: response.userId,
                                userName: response.userName,
                                profileImageUrl: response.profileImageUrl ?? "",
                                treehouses: response.treehouseIdList, treehouseInfo: [])
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            isLogin = false
            
            return nil
        }
    }
    
    func readMyProfileInfo(treehouseId: [Int]) async -> [TreehouseInfo] {
        var treehouse = [TreehouseInfo]()
        
        await withTaskGroup(of: (TreehouseInfo?).self) { group in
            for id in treehouseId {
                group.addTask {
                    let result = await self.readMyProfileInfoUseCase.execute(treehouseId: id)
                    
                    switch result {
                    case .success(let response):
                        let url = URL(string: response.profileImageUrl)
                        return TreehouseInfo(treehouseId: id, treehouseMemberId: response.memberId,
                                      treehouseName: response.memberName,
                                      bio: response.bio,
                                      profileImageUrl: url)
                        
                    case .failure(let error):
                        return nil
                    }
                }
            }

            for await treehouseInfo in group {
                if let info = treehouseInfo {
                    treehouse.append(info)
                }
            }
        }
        
        return treehouse
    }
    
    func userLogin(phoneNumber: String) async -> UserInfoData? {
        var loginResult = await existsUserLogin(phoneNumber: phoneNumber)
        
        guard let result = loginResult else { return nil }
        
        let myProfileResult = await readMyProfileInfo(treehouseId: result.treehouses)
        
        loginResult?.treehouseInfo = myProfileResult
        
        isLogin = true
        
        return loginResult
    }
}
