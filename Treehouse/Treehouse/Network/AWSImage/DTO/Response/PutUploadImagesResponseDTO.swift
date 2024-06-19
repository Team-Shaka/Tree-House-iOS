//
//  PutUploadImagesResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/18/24.
//

import Foundation

struct PutUploadImagesResponseDTO {
    let index: Int
    let result: Bool
    
    func toDomain() -> PutUploadImagesResponseEntity {
        return PutUploadImagesResponseEntity(index: index, result: result)
    }
}
