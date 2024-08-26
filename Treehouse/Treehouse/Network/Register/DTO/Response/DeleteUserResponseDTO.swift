//
//  DeleteUserResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/25/24.
//

import Foundation

struct DeleteUserResponseDTO: Decodable {
    let userId: Int
    
    func toDomain() -> DeleteUserResponseEntity {
        return DeleteUserResponseEntity(userId: userId)
    }
}
