//
//  InvitationRepositoryImpl.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

final class InvitationRepositoryImpl: InvitationRepositoryProtocol {
    private var invitationService = InvitationService()
    
    /// 트리 멤버 초대 수락 / 거부
    func postAcceptInvitationTreeMember(invitationId: Int, acceptDecision: Bool) async -> Result<AcceptInvitationTreeMemberResponseEntity, NetworkError> {
        do {
            let response = try await invitationService.postAcceptInvitationTreeMember(invitationId: invitationId, acceptDecision: acceptDecision)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    /// 초대장 조회
    func getCheckAvailableInvitation() async -> Result<CheckInvitationsReponseEntity, NetworkError> {
        do {
            let response = try await invitationService.getCheckAvailableInvitation()
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
