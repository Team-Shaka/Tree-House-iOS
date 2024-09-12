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
    private let readMemberInfoUseCase: GetReadMemberInfoUseCaseProtocol
    
    @ObservationIgnored
    private let readMemberFeedUseCase: GetReadMemberFeedUseCaseProtocol
    
    var memberProfileData: ReadMemberInfoResponseEntity?
    var errorMessage: String = ""
    
    @ObservationIgnored
    private var treehouseId: Int
    
    @ObservationIgnored
    private var memberId: Int
    
    var memberFeedData: ReadMemberFeedResponseEntity?
    var title = ""
    var isLoading = true
    
    // MARK: - init
    
    init(readMemberInfoUseCase: GetReadMemberInfoUseCaseProtocol,
         readMemberFeedUseCase: GetReadMemberFeedUseCaseProtocol,
         treehouseId: Int,
         memberId: Int
    ) {
        self.readMemberInfoUseCase = readMemberInfoUseCase
        self.readMemberFeedUseCase = readMemberFeedUseCase
        self.treehouseId = treehouseId
        self.memberId = memberId
    }
    
    func performAsyncTasks() async {
        async let memberInfo = readMemberInfo(treehouseId: treehouseId, memberId: memberId)
        async let memberFeed = readMemberFeed(treehouseId: treehouseId, memberId: memberId)
        
        let (memberInfoResult, memberFeedResult) = await (memberInfo, memberFeed)
        
        if memberInfoResult && memberFeedResult {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isLoading = false
            }
        }
    }
}

private extension MemberProfileViewModel {
    func readMemberInfo(treehouseId: Int, memberId: Int) async -> Bool {
        let result = await readMemberInfoUseCase.execute(treehouseId: treehouseId, memberId: memberId)
        
        switch result {
        case .success(let response):
            await MainActor.run {
                memberProfileData = response
                title = response.memberName
            }
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            return false
        }
    }
    
    func readMemberFeed(treehouseId: Int, memberId: Int) async -> Bool {
        let result = await readMemberFeedUseCase.execute(treehouseId: treehouseId, memberId: memberId)
        
        switch result {
        case .success(let response):
            
            await MainActor.run {
                memberFeedData = response
            }
            
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
