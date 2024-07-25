//
//  MemberService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

final class MemberService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// 멤버 프로필 조회하는 APi
    func getReadMemberInfo(treehouseId: Int, memberId: Int) async throws -> GetReadMemberInfoResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: MemberAPI.getReadMemberInfo(treehouseId: treehouseId, memberId: memberId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadMemberInfoResponseDTO.self)
    }
    
    /// 멤버 프로필의 게시글을 조회하는 API
    func getReadMemberFeed(treehouseId: Int, memberId: Int) async throws -> GetReadMemberFeedResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: MemberAPI.getReadMemberFeed(treehouseId: treehouseId, memberId: memberId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadMemberFeedResponseDTO.self)
    }
    
    /// 내 프로필을 조회하는 API
    func getReadMyProfileInfo(treehouseId: Int) async throws -> GetReadMyProfileInfoResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: MemberAPI.getReadMyProfileInfo(treehouseId: treehouseId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadMyProfileInfoResponseDTO.self)
    }
    
    /// 내 프로필을 수정하는 API
    func patchModifyMyProfile(treehouseId: Int, requsetBody: PatchModifyMyProfileRequestDTO) async throws -> PatchModifyMyProfileResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: MemberAPI.patchModifyMyProfile(treehouseId: treehouseId, requestBody: requsetBody))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PatchModifyMyProfileResponseDTO.self)
    }
}
