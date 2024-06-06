//
//  InvitationService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

final class InvitationService {
    /// 트리 멤버 초대 수락 / 거부 API
    func postAcceptInvitationTreeMember(invitationId: Int, isAccepted: Bool) async throws -> PostAcceptInvitationTreeMemberResponseDTO {
        let request = NetworkRequest(requestType: InvitationAPI.postAcceptInvitationTreeMember(requestBody: PostAcceptInvitationTreeMemberRequestDTO(invitationId: invitationId, isAccepted: isAccepted)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON: \(jsonString)")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostAcceptInvitationTreeMemberResponseDTO>.self, from: data)
            return model.data
        } catch {
            throw NetworkError.jsonDecodingError
        }
    }
    
    /// 초대장 조회 API
    func getCheckAvailableInvitation() async throws -> GetCheckInvitationsReponseDTO {
        let request = NetworkRequest(requestType: InvitationAPI.getCheckInvitations)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON: \(jsonString)")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<GetCheckInvitationsReponseDTO>.self, from: data)
            return model.data
        } catch {
            throw NetworkError.jsonDecodingError
        }
    }
}

