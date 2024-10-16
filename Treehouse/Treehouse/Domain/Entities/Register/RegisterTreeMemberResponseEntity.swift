//
//  RegisterTreeMemberResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/3/24.
//

import Foundation

struct RegisterTreeMemberResponseEntity: Decodable {
    let userId: Int
    let memberId: Int
    let treehouseId: Int
}
