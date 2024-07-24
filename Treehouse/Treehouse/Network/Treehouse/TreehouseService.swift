//
//  TreehouseService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

final class TreehouseService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// 트리하우스를 생성하는 API
    func postCreateTreehouse(request: PostCreateTreehouseRequestDTO) async throws -> PostCreateTreehouseResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: TreehouseAPI.postCreateTreehouse(requestBody: request))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCreateTreehouseResponseDTO.self)
    }
    
    /// 트리하우스의 정보를 받는 API
    func getReadTreehouseInfo(treehouseId: Int) async throws -> GetReadTreehouseInfoResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: TreehouseAPI.getReadTreehouseInfo(treehouseId: treehouseId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadTreehouseInfoResponseDTO.self)
    }
}
