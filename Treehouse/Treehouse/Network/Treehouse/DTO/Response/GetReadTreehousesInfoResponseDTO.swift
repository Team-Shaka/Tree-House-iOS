//
//  GetReadTreehousesInfoResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct GetReadTreehousesInfoResponseDTO: Decodable {
    let treehouseId: Int
    let treehouseName: String
    let treehouseSize: Int
    let treehouseImageUrl: String
}
