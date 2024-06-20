//
//  InvitationService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

final class InvitationService {
    /// 트리 멤버 초대 수락 / 거부 API
    func postAcceptInvitationTreeMember(invitationId: Int, acceptDecision: Bool) async throws -> PostAcceptInvitationTreeMemberResponseDTO {
        
        print("1️⃣ PostAcceptInvitationTreeMember API 호출 ========================================")
        print("Input - invitationId: \(invitationId), acceptDecision: \(acceptDecision)")
        
        let request = NetworkRequest(requestType: InvitationAPI.postAcceptInvitationTreeMember(requestBody: PostAcceptInvitationTreeMemberRequestDTO(invitationId: invitationId, acceptDecision: acceptDecision)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
            print("\(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostAcceptInvitationTreeMemberResponseDTO>.self, from: data)
            print(model.data)
            print("4️⃣ PostAcceptInvitationTreeMember API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ PostAcceptInvitationTreeMember API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
    
    /// 초대장 조회 API
    func getCheckInvitation() async throws -> GetCheckInvitationsReponseDTO {
        print("1️⃣ 🔑 GetCheckAvailableInvitation API 호출 ========================================")

        let request = NetworkRequest(requestType: InvitationAPI.getCheckInvitations)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
            print("\(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<GetCheckInvitationsReponseDTO>.self, from: data)
            print(model.data.invitations)
            print("4️⃣ GetCheckAvailableInvitation API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ GetCheckAvailableInvitation API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
    
    /// 소유한 초대장 개수 및 게이지 조회 API
    func getCheckAvailableInvitation() async throws -> GetCheckAvailableInvitationResponseDTO {
        let request = NetworkRequest(requestType: InvitationAPI.getCheckAvailableInvitation)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<GetCheckAvailableInvitationResponseDTO>.self, from: data)
            return model.data
        } catch {
            print("4️⃣ GetCheckAvailableInvitation API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
}

