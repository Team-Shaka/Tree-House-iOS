//
//  GetReadMyTreehouseInfoResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/30/24.
//

import Foundation

struct GetReadMyTreehouseInfoResponseDTO: Decodable {
    let treehouses: [GetReadTreehouseInfoResponseDTO]
    
    func toDomain() -> ReadMyTreehouseInfoResponseEntity {
        return ReadMyTreehouseInfoResponseEntity(treeohouses: convertTreehouseInfoEntity(treehouses))
    }
    
    private func convertTreehouseInfoEntity(_ data: [GetReadTreehouseInfoResponseDTO]) -> [ReadTreehouseInfoResponseEntity] {
        var result = [ReadTreehouseInfoResponseEntity]()
        
        data.forEach {
            result.append(ReadTreehouseInfoResponseEntity(treehouseId: $0.treehouseId, treehouseName: $0.treehouseName, treehouseSize: $0.treehouseSize, treehouseImageUrl: $0.treehouseImageUrl))
        }
        
        return result
    }
}
