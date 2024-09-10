//
//  PostRegisterPushAgreeResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation

struct PostRegisterPushAgreeResponseDTO: Decodable {
    let userId: Int
    let pushAgree: Bool
    
    func toDomain() -> RegisterPushAgreeResponseEntity {
        return RegisterPushAgreeResponseEntity(userId: userId, pushAgree: pushAgree)
    }
}
