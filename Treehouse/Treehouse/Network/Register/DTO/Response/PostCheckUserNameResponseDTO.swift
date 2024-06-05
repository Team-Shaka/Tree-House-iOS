//
//  PostCheckUserNameResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostCheckUserNameResponseDTO: Decodable {
    let isDuplicated: Bool
    
    func toDomain() -> CheckNameResponseEntity {
        return CheckNameResponseEntity(isDuplicated:  isDuplicated)
    }
}
