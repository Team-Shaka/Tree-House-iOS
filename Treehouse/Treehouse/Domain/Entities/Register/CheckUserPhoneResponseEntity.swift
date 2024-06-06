//
//  CheckUserPhoneResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/6/24.
//

import Foundation

struct CheckUserPhoneResponseEntity: Decodable {
    let isNewUser: Bool
    let isInvited: Bool
}
