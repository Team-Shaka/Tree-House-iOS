//
//  TreehouseRepositoryProtocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol TreehouseRepositoryProtocol {
    func getReadMyTreehousesInfo() async -> Result<ReadMyTreehouseInfoResponseEntity, NetworkError>
    func postCreateTreehouse(request: PostCreateTreehouseRequestDTO) async -> Result<CreateTreehouseResponseEntity,NetworkError>
    func getReadTreehousesInfo(treehouseId: Int) async -> Result<ReadTreehouseInfoResponseEntity,NetworkError>
    func postCheckTreehouseName(treehouseName: String) async -> Result<CheckTreehouseNameResponseEntity, NetworkError>
}
