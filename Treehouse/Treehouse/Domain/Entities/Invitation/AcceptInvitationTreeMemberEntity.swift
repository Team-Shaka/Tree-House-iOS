//
//  AcceptInvitationTreeMemberEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/4/24.
//

import Foundation

struct AcceptInvitationTreeMemberResponseEntity: Decodable {
    let treehouseId: Int
    let isAccepted: Bool
}
