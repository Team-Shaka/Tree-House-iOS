//
//  AvailableInvitationStruct.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/21/24.
//

import Foundation

struct AvailableInvitationStruct: Decodable {
    let availableInvitation: Int
    let activeRate: Int
}

extension AvailableInvitationStruct {
    static let availableInvitationDummyData: AvailableInvitationStruct = AvailableInvitationStruct(availableInvitation: 3, activeRate: 70)
}
