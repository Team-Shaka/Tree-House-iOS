//
//  TreehouseRepositoryImpl.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

final class TreehouseRepositoryImpl: TreehouseRepositoryProtocol {
    private var treehouseService = TreehouseService()
    
    func getReadMyTreehousesInfo() async -> Result<ReadMyTreehouseInfoResponseEntity, NetworkError> {
        do {
            let response = try await treehouseService.getReadMyTreehousesInfo()
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func postCreateTreehouse(request: PostCreateTreehouseRequestDTO) async -> Result<CreateTreehouseResponseEntity, NetworkError> {
        do {
            let response = try await treehouseService.postCreateTreehouse(request: request)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func getReadTreehousesInfo(treehouseId: Int) async -> Result<ReadTreehouseInfoResponseEntity, NetworkError> {
        do {
            let response = try await treehouseService.getReadTreehouseInfo(treehouseId: treehouseId)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func postCheckTreehouseName(treehouseName: String) async -> Result<CheckTreehouseNameResponseEntity, NetworkError> {
        do {
            let response = try await treehouseService.postCheckTreehouseName(treehouseName: treehouseName)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}

