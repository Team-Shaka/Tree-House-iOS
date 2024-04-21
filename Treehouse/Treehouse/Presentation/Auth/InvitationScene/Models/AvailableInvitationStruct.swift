//
//  AvailableInvitationStruct.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/21/24.
//

import Foundation

struct AvailableInvitationStruct: Hashable, Identifiable {
    let id = UUID()
    let availableInvitation: Int
    let activeRate: Int
}
