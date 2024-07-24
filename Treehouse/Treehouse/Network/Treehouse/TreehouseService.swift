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
    func postCreateTreehouses(request: PostCreateTreehousesRequestDTO) async throws -> PostCreateTreehousesResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: TreehouseAPI.postCreateTreehouses(requestBody: request))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCreateTreehousesResponseDTO.self)
    }
    
    /// 트리하우스의 정보를 받는 API
    func getReadTreehousesInfo(treehouseId: Int) async throws -> GetReadTreehousesInfoResponseDTO {
        
        // 요청 DTO 생성
        let request = NetworkRequest(requestType: TreehouseAPI.getReadTreehousesInfo(treehouseId: treehouseId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadTreehousesInfoResponseDTO.self)
    }
}
