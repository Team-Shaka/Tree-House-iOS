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
    
    var errorMessage: String? = nil
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol
    
    @ObservationIgnored
    private let checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol
    
    @ObservationIgnored
    private let checkAvailableInvitationUseCase: GetCheckAvailableInvitationUseCaseProtocol
    
    // MARK: - init
    
    init(
        acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol,
         checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol,
         checkAvailableInvitationUseCase: GetCheckAvailableInvitationUseCaseProtocol
    ) {
        self.acceptInvitationTreeMemberUseCase = acceptInvitationTreeMemberUseCase
        self.checkInvitationsUseCase = checkInvitationsUseCase
        self.checkAvailableInvitationUseCase = checkAvailableInvitationUseCase
    }
}

// MARK: - Invitation API Extension

extension InvitationViewModel {
    func acceptInvitationTreeMember(invitationId: Int, isAccepted: Bool) async {
        let result = await acceptInvitationTreeMemberUseCase.execute(invitationId: invitationId, acceptDecision: isAccepted)
        
        switch result {
        case .success(let response):
            // TODO: - invitationid 연결
            await MainActor.run {
                response.treehouseId
            }
            
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
//            response.invitations.forEach {
//                treehouseName = $0.treehouseName
//                invitedMember = $0.senderName
//                memberNum = $0.treehouseSize
//                memberProfileImages = $0.treehouseMemberProfileImages
//            }
            
            treehouseName = "점심팟"
            invitedMember = "Chriiii0o0"
            memberNum = 20
//            memberProfileImages = $0.treehouseMemberProfileImages
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
