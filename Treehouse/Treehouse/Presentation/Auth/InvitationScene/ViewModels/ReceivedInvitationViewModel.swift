//
//  ReceivedInvitationViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/22/24.
//

import Observation

@Observable
final class ReceivedInvitationViewModel: BaseViewModel {
    var viewState: ReceivedInvitationViewStateType = .invitation
    var presentAlert: Bool = false
    var tapInvitationData: CheckInvitationsDataReponseEntity? = nil
    var errorMessage: String? = nil
    
    var receivedInvitations: [CheckInvitationsDataReponseEntity] = []
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol
    
    @ObservationIgnored
    private let acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol
    
    // MARK: - init
    
    init(checkInvitationsUseCase: GetCheckInvitationsUseCaseProtocol,
         acceptInvitationTreeMemberUseCase: PostAcceptInvitationTreeMemberUseCaseProtocol) {
        self.checkInvitationsUseCase = checkInvitationsUseCase
        self.acceptInvitationTreeMemberUseCase = acceptInvitationTreeMemberUseCase
    }
}

extension ReceivedInvitationViewModel {
    func checkInvitations() async {
        let result = await checkInvitationsUseCase.execute()
        
        switch result {
        case .success(let response):
            receivedInvitations = response.invitations
            viewState = receivedInvitations.isEmpty ? .unInvitation : .invitation
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    func acceptInvitationTreeMember(acceptDecision: Bool) async -> Bool {
        guard let selectInvitationData = tapInvitationData else { return false }

        let result = await acceptInvitationTreeMemberUseCase.execute(invitationId: selectInvitationData.invitationId, acceptDecision: acceptDecision)
        
        switch result {
        case .success(_):
            return true
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            return false
        }
    }
}
