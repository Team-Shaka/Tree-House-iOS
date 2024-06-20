//
//  PostPresignedURLResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

struct PostPresignedURLResponseDTO: Decodable {
    let presignedUrl: String
    let accessUrl: String
    
    func toDomain() -> PresignedURLResponseEntity {
        return PresignedURLResponseEntity(presignedUrl: presignedUrl, accessUrl: accessUrl)
    }
}
