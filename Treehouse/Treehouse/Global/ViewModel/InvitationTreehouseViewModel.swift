//
//  InvitationTreehouseViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/12/24.
//

import Foundation
import Observation

@Observable
final class InvitationTreehouseViewModel: BaseViewModel {
    
    // MARK: - Property
    
    var treehouseInfo: [ReadTreehouseInfoResponseEntity]?
    var availableInvitation: Int = 0
    var activeRate: Int = 0
    var isSelectTreehouse: Bool = false {
        didSet {
            if isSelectTreehouse == false {
                self.selectedTreehouseId = nil
            }
        }
    }
    var errorMessage: String = ""
    
    @ObservationIgnored
    var senderId: Int?
    
    @ObservationIgnored
    var memberPhoenNumber: String?
    
    @ObservationIgnored
    var selectedTreehouseId: Int?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let readMyTreehouseInfoUseCase: GetReadMyTreehouseInfoUseCaseProtocol
    
    @ObservationIgnored
    private let checkAvailableInvitationUseCase: GetCheckAvailableInvitationUseCaseProtocol
    
    @ObservationIgnored
    private let invitationUseCase: PostInvitationUseCaseProtocol
    
    init(readMyTreehouseInfoUseCase: GetReadMyTreehouseInfoUseCaseProtocol,
         checkAvailableInvitationUseCase: GetCheckAvailableInvitationUseCaseProtocol,
         invitationUseCase: PostInvitationUseCaseProtocol) {
        self.readMyTreehouseInfoUseCase = readMyTreehouseInfoUseCase
        self.checkAvailableInvitationUseCase = checkAvailableInvitationUseCase
        self.invitationUseCase = invitationUseCase
        
        print("init InvitationTreehouseViewModel")
    }
    
    deinit {
        print("Deinit InvitationTreehouseViewModel")
    }
    
    func invitationTreehouseTapped(treehouseId: Int) {
        guard treehouseInfo != nil else { return }
        
        findSelectedTreehouse(treehouseId)

        if let findTreehouseIndex = treehouseInfo?.firstIndex(where: { $0.treehouseId == treehouseId }) {
            
            if treehouseInfo?[findTreehouseIndex].currentTreeHouse == false {
                treehouseInfo?[findTreehouseIndex].currentTreeHouse = true
                isSelectTreehouse = true
                selectedTreehouseId = treehouseId
            } else {
                treehouseInfo?[findTreehouseIndex].currentTreeHouse = false
                isSelectTreehouse = false
            }
        } else {
            isSelectTreehouse = false
        }
    }
    
    /// 이미 선택된 Treehouse 가 존재하면 false 로 변경하는 메서드
    private func findSelectedTreehouse(_ treehouseId: Int) {
        if let selectedIndex = treehouseInfo?.firstIndex(where: { $0.currentTreeHouse == true }) {
            
            if treehouseInfo?[selectedIndex].treehouseId != treehouseId {
                treehouseInfo?[selectedIndex].currentTreeHouse = false
            }
        }
    }
}

// MARK: - Treehouse API Extension

extension InvitationTreehouseViewModel {
    func performAsyncTasks(currentTreehouseId: Int) async {
        // 비동기 작업을 순차적으로 호출
        await readMyTreehouseInfo(currentTreehouseId: currentTreehouseId)
        await checkAvailableInvitation()
    }
    
    /// 내 트리하우스를 조회하는 API
    func readMyTreehouseInfo(currentTreehouseId: Int) async {
        let result = await readMyTreehouseInfoUseCase.execute()
        
        switch result {
        case .success(let response):
            treehouseInfo = response.treeohouses
  
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
    }
    
    func checkAvailableInvitation() async {
        let result = await checkAvailableInvitationUseCase.execute()
        
        switch result {
        case .success(let response):
            await MainActor.run {
                availableInvitation = response.availableInvitation
                activeRate = response.activeRate
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func invitationTreehouse() async -> Bool {
        guard let senderId = senderId, let memberPhoenNumber = memberPhoenNumber, let selectedTreehouseId = selectedTreehouseId else {
            return false
        }
        
        let result = await invitationUseCase.execute(senderId: senderId, phoneNumber: memberPhoenNumber, treehouseId: selectedTreehouseId)
        
        switch result {
        case .success(_):
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            return false
        }
    }
}
