//
//  PostCreateTreehouseResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct PostCreateTreehouseResponseDTO: Codable {
    let treehouseId: Int
    
    func toDomain() -> CreateTreehouseResponseEntity {
        return CreateTreehouseResponseEntity(treehouseId: treehouseId)
    }
}
