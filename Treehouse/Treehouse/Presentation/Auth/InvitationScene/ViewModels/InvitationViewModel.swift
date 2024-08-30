//
//  InvitationViewModel.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/20/24.
//

import Foundation
import Observation

@Observable
final class InvitationViewModel: BaseViewModel {
    
    // MARK: - Invitation Property
    
    var treehouseName: String = ""
    var invitedMember: String = ""
    var memberNum: Int = 0
    var memberProfileImages: [URL] = []
    var availableInvitation: Int = 0
    var activeRate: Int = 0
    var invitationCount = 0
    
    var errorMessage: String? = nil
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol
    
    @ObservationIgnored
    private let checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol
    
    @ObservationIgnored
    private let checkAvailableInvitationUseCase: GetCheckAvailableInvitationUseCaseProtocol
    
    @ObservationIgnored
    private let invitationUseCase: PostInvitationUseCaseProtocol
    
    // MARK: - init
    
    init(acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol,
         checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol,
         checkAvailableInvitationUseCase: GetCheckAvailableInvitationUseCaseProtocol,
         invitationUseCase: PostInvitationUseCaseProtocol
    ) {
        self.acceptInvitationTreeMemberUseCase = acceptInvitationTreeMemberUseCase
        self.checkInvitationsUseCase = checkInvitationsUseCase
        self.checkAvailableInvitationUseCase = checkAvailableInvitationUseCase
        self.invitationUseCase = invitationUseCase
    }
}

// MARK: - Invitation API Extension

extension InvitationViewModel {
    func invitationTreehouse(senderId: Int, phoneNumber: String, treehouseId: Int) async -> Bool {
        print(senderId)
        print(phoneNumber)
        print(treehouseId)
        let result = await invitationUseCase.execute(senderId: senderId, phoneNumber: phoneNumber, treehouseId: treehouseId)
        
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
    
    func acceptInvitationTreeMember(invitationId: Int, isAccepted: Bool) async {
        let result = await acceptInvitationTreeMemberUseCase.execute(invitationId: invitationId, acceptDecision: isAccepted)
        
        switch result {
        case .success(_):
            break
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func checkInvitations() async {
        let result = await checkInvitationsUseCase.execute()
        
        switch result {
        case .success(let response):
            await MainActor.run {
                invitationCount = response.invitations.count
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
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
}
