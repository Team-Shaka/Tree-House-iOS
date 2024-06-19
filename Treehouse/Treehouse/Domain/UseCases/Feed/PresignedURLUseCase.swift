//
//  PresignedURLUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

protocol PostPresignedURLUseCaseProtocol {
    func execute(treehouseId: Int, fileName: String, fileSize: Int) async -> Result<PresignedURLResponseEntity, NetworkError>
}

final class PresignedURLUseCase: PostPresignedURLUseCaseProtocol {
    private let repository: FeedRepositoryProtocol
    
    init(repository: FeedRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(treehouseId: Int, fileName: String, fileSize: Int) async -> Result<PresignedURLResponseEntity, NetworkError> {
        return await repository.postPresignedURL(treehouseId: treehouseId, fileName: fileName, fileSize: fileSize)
    }
}
