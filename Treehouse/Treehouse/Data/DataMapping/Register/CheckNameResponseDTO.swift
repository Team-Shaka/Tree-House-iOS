//
//  CheckNameResponseDTO.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/27/24.
//

import Foundation

struct CheckNameResponseDTO: Codable {
    let isDuplicated: Bool
    
    func toDomain() -> CheckNameResponseEntity {
        return CheckNameResponseEntity(isDuplicated:  isDuplicated)
    }
}
