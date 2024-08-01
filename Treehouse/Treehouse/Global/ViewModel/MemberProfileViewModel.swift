//
//  MemberProfileViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/1/24.
//

import Foundation

import Observation

@Observable
final class MemberProfileViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let readMemberInfoUseCase:  GetReadMemberInfoUseCaseProtocol
    
    var memberProfileData: ReadMemberInfoResponseEntity?
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(readMemberInfoUseCase: GetReadMemberInfoUseCaseProtocol) {
        self.readMemberInfoUseCase = readMemberInfoUseCase
    }
}

extension MemberProfileViewModel {
    func readMemberInfo(treehouseId: Int, memberId: Int) async -> Bool {
        let result = await readMemberInfoUseCase.execute(treehouseId: treehouseId, memberId: memberId)
        
        switch result {
        case .success(let response):
            memberProfileData = response
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
