//
//  PostRegisterTreeMemberResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostRegisterTreeMemberResponseDTO: Decodable {
    let userId: Int
    let treehouseId: Int
    
    func toDomain() -> RegisterTreeMemberResponseEntity {
        return RegisterTreeMemberResponseEntity(userId: userId, treehouseId: treehouseId)
    }
}
