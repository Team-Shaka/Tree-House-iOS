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
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(readMyProfileInfoUseCase: GetReadMyProfileInfoUseCaseProtocol) {
        self.readMyProfileInfoUseCase = readMyProfileInfoUseCase
    }
}

extension MyProfileViewModel {
    func readMyProfileInfo(treehouseId: Int) async -> Bool {
        let result = await readMyProfileInfoUseCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            myProfileData = response
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            return false
        }
    }
}
