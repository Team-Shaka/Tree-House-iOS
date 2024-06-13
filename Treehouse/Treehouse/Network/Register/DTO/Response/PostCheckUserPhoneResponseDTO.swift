//
//  PostCheckUserPhoneResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/6/24.
//

import Foundation

struct PostCheckUserPhoneResponseDTO: Decodable {
    let isNewUser: Bool
    let isInvited: Bool
    
    func toDomain() -> CheckUserPhoneResponseEntity {
        return CheckUserPhoneResponseEntity(isNewUser: isNewUser, isInvited: isInvited)
    }
}
