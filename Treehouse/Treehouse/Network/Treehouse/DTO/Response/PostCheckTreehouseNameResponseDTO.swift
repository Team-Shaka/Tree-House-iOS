//
//  GetCheckTreehouseNameResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/7/24.
//

import Foundation

struct PostCheckTreehouseNameResponseDTO: Codable {
    let isAvailable: Bool
    
    func toDomain() -> CheckTreehouseNameResponseEntity {
        return CheckTreehouseNameResponseEntity(isAvailable: isAvailable)
    }
}
