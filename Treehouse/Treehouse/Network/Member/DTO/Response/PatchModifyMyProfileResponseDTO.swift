//
//  PatchModifyMyProfileResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct PatchModifyMyProfileResponseDTO: Decodable {
    let memberId: Int
    
    func toDomain() -> PatchModifyMyProfileResponseEntity {
        PatchModifyMyProfileResponseEntity(memberId: memberId)
    }
}
