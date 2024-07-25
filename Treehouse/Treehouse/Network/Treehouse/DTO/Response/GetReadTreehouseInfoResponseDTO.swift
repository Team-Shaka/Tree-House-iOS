//
//  GetReadTreehouseInfoResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct GetReadTreehouseInfoResponseDTO: Decodable {
    let treehouseId: Int
    let treehouseName: String
    let treehouseSize: Int
    let treehouseImageUrl: String
    
    func toDomain() -> ReadTreehouseInfoResponseEntity {
        return ReadTreehouseInfoResponseEntity(
            treehouseId: treehouseId,
            treehouseName: treehouseName,
            treehouseSize: treehouseSize,
            treehouseImageUrl: treehouseImageUrl
        )
    }
}
