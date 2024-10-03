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
    
    var currentTreehouseId: Int = 0
    var selectedIndex: Int = 0
    var invitedMember: String = ""
    var invitedPhoneNumber: String = ""
    var senderId: Int = 0
    var memberProfileImages: [URL] = []
    var availableInvitation: Int = 0
    var activeRate: Int = 0
    var invitationCount = 0
    var isinvitationAlert = false
    var invitationState: invitationState?
    
    var invitationTitle = "완료되었습니다."
    var invitationError = false
    
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
    
    // 초대하기 버튼을 눌렀을 때 (alert 표시)
    func invitationButtonTapped(index: Int, name: String, phoneNumber: String) {
        if availableInvitation > 0 {
            selectedIndex = index
            invitedMember = name
            invitedPhoneNumber = phoneNumber
            invitationState = .success
        } else {
            invitationState = .faliure
        }
        
        isinvitationAlert = true
    }
}

// MARK: - Invitation API Extension

extension InvitationViewModel {
    func invitationTreehouse() async -> Bool {
        let result = await invitationUseCase.execute(senderId: senderId, phoneNumber: invitedPhoneNumber, treehouseId: currentTreehouseId)
        
        invitedMember = ""
        invitedPhoneNumber = ""
        
        switch result {
        case .success(_):
            return true
        case .failure(let error):
            invitationError = true
            invitationState = .duplication
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func invitationTreehouse(senderId: Int, phoneNumber: String, treehouseId: Int) async -> Bool {
        let result = await invitationUseCase.execute(senderId: senderId, phoneNumber: invitedPhoneNumber, treehouseId: treehouseId)
        
        switch result {
        case .success(_):
            return true
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            
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
