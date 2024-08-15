//
//  CheckTreehouseNameUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/7/24.
//

import Foundation

import Foundation

protocol PostCheckTreehouseNameUseCaseProtocol {
    func execute(treehouseName: String) async -> Result<CheckTreehouseNameResponseEntity, NetworkError>
}

final class CheckTreehouseNameUseCase: PostCheckTreehouseNameUseCaseProtocol {
    private let repository: TreehouseRepositoryProtocol
    
    init(repository: TreehouseRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseName: String) async -> Result<CheckTreehouseNameResponseEntity, NetworkError> {
        return await repository.postCheckTreehouseName(treehouseName: treehouseName)
    }
}
