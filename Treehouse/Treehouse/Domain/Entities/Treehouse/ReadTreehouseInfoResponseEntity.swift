//
//  ReadTreehouseInfoResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct ReadTreehouseInfoResponseEntity: Identifiable, Decodable {
    var id = UUID()
    let treehouseId: Int
    let treehouseName: String
    let treehouseSize: Int
    let treehouseImageUrl: String?
    var currentTreeHouse: Bool = false
}
