//
//  ReadMyTreehouseInfoUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/30/24.
//

import Foundation

protocol GetReadMyTreehouseInfoUseCaseProtocol {
    func execute() async -> Result<ReadMyTreehouseInfoResponseEntity, NetworkError>
}

final class ReadMyTreehouseInfoUseCase: GetReadMyTreehouseInfoUseCaseProtocol {
    private let repository: TreehouseRepositoryProtocol
    
    init(repository: TreehouseRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async -> Result<ReadMyTreehouseInfoResponseEntity, NetworkError> {
        return await repository.getReadMyTreehousesInfo()
    }
}
