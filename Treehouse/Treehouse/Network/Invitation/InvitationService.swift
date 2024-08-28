//
//  InvitationService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

final class InvitationService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// 트리하우스 초대 API
    func postInvitation(senderId: Int, phoneNumber: String, treehouseId: Int) async throws -> PostInvitationResponseDTO {
        let request = NetworkRequest(requestType: InvitationAPI.postInvitation(requestBody: PostInvitationRequestDTO(senderId: senderId, phoneNumber: phoneNumber, treehouseId: treehouseId)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostInvitationResponseDTO.self)
    }
    
    /// 트리 멤버 초대 수락 / 거부 API
    func postAcceptInvitationTreeMember(invitationId: Int, acceptDecision: Bool) async throws -> PostAcceptInvitationTreeMemberResponseDTO {
        
        let request = NetworkRequest(requestType: InvitationAPI.postAcceptInvitationTreeMember(requestBody: PostAcceptInvitationTreeMemberRequestDTO(invitationId: invitationId, acceptDecision: acceptDecision)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostAcceptInvitationTreeMemberResponseDTO.self)
    }
    
    /// 초대장 조회 API
    func getCheckInvitation() async throws -> GetCheckInvitationsReponseDTO {

        let request = NetworkRequest(requestType: InvitationAPI.getCheckInvitations)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetCheckInvitationsReponseDTO.self)
    }
    
    /// 소유한 초대장 개수 및 게이지 조회 API
    func getCheckAvailableInvitation() async throws -> GetCheckAvailableInvitationResponseDTO {
        let request = NetworkRequest(requestType: InvitationAPI.getCheckAvailableInvitation)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetCheckAvailableInvitationResponseDTO.self)
    }
}
