//
//  ReadTreehouseInfoUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

protocol GetReadTreehouseInfoUseCaseProtocol {
    func execute(treehouseId: Int) async -> Result<ReadTreehouseInfoResponseEntity, NetworkError>
}

final class ReadTreehouseInfoUseCase: GetReadTreehouseInfoUseCaseProtocol {
    private let repository: TreehouseRepositoryProtocol
    
    init(repository: TreehouseRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int) async -> Result<ReadTreehouseInfoResponseEntity, NetworkError> {
        return await repository.getReadTreehousesInfo(treehouseId: treehouseId)
    }
}
