//
//  TreehouseService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

final class TreehouseService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// 내 트리하우스 정보를 받는 API
    func getReadMyTreehousesInfo() async throws -> GetReadMyTreehouseInfoResponseDTO {
        
        let request = NetworkRequest(requestType: TreehouseAPI.getReadMyTreehouseInfo)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadMyTreehouseInfoResponseDTO.self)
    }
    
    /// 트리하우스를 생성하는 API
    func postCreateTreehouse(request: PostCreateTreehouseRequestDTO) async throws -> PostCreateTreehouseResponseDTO {
        
        let request = NetworkRequest(requestType: TreehouseAPI.postCreateTreehouse(requestBody: request))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCreateTreehouseResponseDTO.self)
    }
    
    /// 트리하우스의 정보를 받는 API
    func getReadTreehouseInfo(treehouseId: Int) async throws -> GetReadTreehouseInfoResponseDTO {
        
        let request = NetworkRequest(requestType: TreehouseAPI.getReadTreehouseInfo(treehouseId: treehouseId))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: GetReadTreehouseInfoResponseDTO.self)
    }
    
    /// 트리하우스의 이름 중복 체크하는 API
    func postCheckTreehouseName(treehouseName: String) async throws -> PostCheckTreehouseNameResponseDTO {
        
        let request = NetworkRequest(requestType: TreehouseAPI.postCheckTreehouseName(requestBody: PostCheckTreehouseNameRequestDTO(treehouseName: treehouseName)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCheckTreehouseNameResponseDTO.self)
    }
}
