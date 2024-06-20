//
//  FeedRepositoryProtocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

protocol FeedRepositoryProtocol {
    func postPresignedURL(treehouseId: Int, fileName: String, fileSize: Int) async -> Result<PresignedURLResponseEntity,NetworkError>
}
